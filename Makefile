# Désactive l'affichage des messages "Entering directory ..." et "Leaving directory ..."
MAKEFLAGS += --no-print-directory

CC      := gcc
CFLAGS  := -Wall -Wextra -O2

SRC_DIR := src
BIN_DIR := bin

# Récupère tous les dossiers (problèmes) présents dans src
PROBLEMS := $(notdir $(wildcard $(SRC_DIR)/*))

# Pour chaque problème, on crée bin/PROBLEME/PROBLEME.exe
TARGETS := $(foreach prob, $(PROBLEMS), $(BIN_DIR)/$(prob)/$(prob).exe)

.PHONY: all run clean

all: $(TARGETS)

# Génération d'une règle explicite pour chaque problème
define make_rule
$(BIN_DIR)/$1/$1.exe: $(SRC_DIR)/$1/$1.c
	@mkdir -p $(BIN_DIR)/$1
	@$(CC) $(CFLAGS) -o $$@ $$<
endef

$(foreach prob, $(PROBLEMS), $(eval $(call make_rule,$(prob))))

# Exécution d'un problème donné
# Utilisation : make run RUN=test
run:
	@if [ -z "$(RUN)" ]; then \
		echo "Usage: make run RUN=NomDuProbleme"; \
		exit 1; \
	fi
	@$(MAKE) -s $(BIN_DIR)/$(RUN)/$(RUN).exe
	@cd $(BIN_DIR)/$(RUN) && ./$(RUN).exe

clean:
	@rm -rf $(BIN_DIR)
