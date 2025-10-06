# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thblack- <thblack-@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/24 14:57:58 by thblack-          #+#    #+#              #
#    Updated: 2025/10/06 19:08:33 by thblack-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# PROJECT NAME
PROJECT		= template
NAME		= template

# PROJECT DIRECTORIES
SRC_DIR		= src
OBJ_DIR		= obj
INC_DIR		= inc

# PROJECT SOURCES: Explicitly states
SRC_FILES	= template.c
SRC_DEV		= $(shell find src -name "*.c")
SRC			= $(SRC_DEV)
# SRC			= $(addprefix $(SRC_DIR)/, $(SRC_FILES))

# PROJECT HEADER
HEADER		= $(INC_DIR)/template.h

# PROJECT OBJECTS
OBJ		= $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC))

# TOOLS
CC			= cc
CFLAGS		= -Wall -Wextra -Werror
CGENERAL	= -O2
CFAST		= -O3
CDEBUG		= -g -O0
MAKE_QUIET	= --no-print-directory
MAKE_LIB	= make -C

# REMOVE
RMFILE = rm -f
RMDIR = rm -rf

# MAKE DIRECTORY
MKDIR		= mkdir -p

# LIBFT LINKING
LIBFT_DIR	= ./libft
LIBFT_H		= $(LIBFT_DIR)/libft.h
LIBFT_A		= $(LIBFT_DIR)/libft.a

# INCLUDE PATHS AND LIBRARIES
INC			= -I. -I$(LIBFT_DIR) -I$(INC_DIR)
LIBFT		= -L$(LIBFT_DIR) -lft
LIBS		= $(LIBFT)

# MESSAGES
START		= @echo "==== THOMASROFF MAKEFILE =============" \
			  && echo "==== STARTED: $(shell date '+%Y-%m-%d %H:%M:%S') ===="
BUILD_PROJ	= @echo "==== BUILDING $(PROJECT) ==============="
BUILD_LIBFT	= @echo "==== BUILDING LIBFT =================="
COMPILED	= @echo "$(PROJECT) compiled successfully"
FINISH		= @echo "==== BUILD COMPLETE ==================" \
			  && echo "==== FINISHED: $(shell date '+%Y-%m-%d %H:%M:%S') ==="
SPACER		= @echo ""

# <<<<<<< MAIN TARGETS >>>>>>>

all: $(NAME)

$(NAME): $(OBJ) $(LIBFT_A)
	$(START)
	$(BUILD_PROJ)
	@$(CC) $(CFLAGS) $(INC) $(OBJ) $(LIBS) -o $(NAME)
	$(COMPILED)
	$(FINISH)

$(LIBFT_A):
	@$(MAKE_LIB) $(LIBFT_DIR) $(MAKE_QUIET)
	$(SPACER)

$(OBJ_DIR):
	@$(MKDIR) $(OBJ_DIR)

 $(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) $(INC) -c $< -o $@

.SECONDARY: $(OBJ) 

# <<<<<<< PHONY TARGETS >>>>>>>

clean:
	@echo "Removing object files"
	@$(RMDIR) $(OBJ_DIR)
	@$(MAKE_LIB) libft clean $(MAKE_QUIET)

fclean:
	@echo "Removing object files"
	@$(RMDIR) $(OBJ_DIR)
	@echo "Removing static library files"
	@$(RMFILE) $(NAME)
	@$(MAKE_LIB) libft fclean $(MAKE_QUIET)

re: fclean all

.PHONY: all clean fclean re debug
