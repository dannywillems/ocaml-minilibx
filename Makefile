#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: dwillems <dwillems@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2016/07/31 06:15:42 by dwillems          #+#    #+#             *#
#*   Updated: 2016/07/31 16:29:12 by dwillems         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

CC_BYT		= ocamlfind ocamlc
CC_OPT		= ocamlfind ocamlopt
CC			= $(CC_BYT)

MLI			= minilibx.mli
ML			= minilibx.ml

CMI			= $(patsubst %.mli,%.cmi,$(MLI))
CMX			= $(patsubst %.ml,%.cmx,$(ML))
CMO			= $(patsubst %.ml,%.cmo,$(ML))
INC_MLX		= /usr/local/lib

PKG			= -package ctypes.foreign -linkpkg
CLIB		=	-cclib "-Wl,--whole-archive" \
				-cclib -lmlx \
				-cclib -lbsd \
				-cclib "-Wl,--no-whole-archive" \
				-cclib "-Wl,-E" \
				-cclib -lX11 \
				-cclib -lXext

COPT		= -ccopt -L$(INC_MLX)

ML_EXE		=	hello.ml
BYT			=	$(patsubst %.ml,%.byte,$(ML_EXE))
OPT			=	$(patsubst %.ml,%.native,$(ML_EXE))
OBJ			=	$(patsubst %.ml,%.o,$(ML_EXE)) $(patsubst %.ml,%.o,$(ML)) \
				$(patsubst %.ml,%.cmi,$(ML_EXE)) \
				$(patsubst %.ml,%.cmo,$(ML_EXE)) \
				$(patsubst %.ml,%.cmx,$(ML_EXE))

all: $(EXE)

%.cmx:%.ml
	$(CC_OPT) -c $(PKG) $<

%.cmo:%.ml
	$(CC_BYT) -c $(PKG) $<

%.cmi:%.mli
	$(CC_BYT) -c $(PKG) $<

$(BYT): $(CMI) $(CMO)
	$(CC_BYT) $(PKG) $(COPT) $(CLIB) $(CMO) -custom $(ML_EXE) -o $@

$(OPT): $(CMI) $(CMX)
	$(CC_OPT) -o $@ $(COPT) $(CLIB) $(PKG) $(CMX) $(ML_EXE)

clean:
	echo $(CMO)
	$(RM) $(CMI) $(CMX) $(CMO) $(OBJ)

fclean: clean
	$(RM) $(BYT) $(OPT)

re: fclean all
