#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: dwillems <dwillems@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2016/07/31 06:15:42 by dwillems          #+#    #+#             *#
#*   Updated: 2016/07/31 16:37:08 by dwillems         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

CC_BYT		=	ocamlfind ocamlc
CC_OPT		=	ocamlfind ocamlopt
CC			=	$(CC_BYT)

MLI			=	minilibx.mli
ML			=	minilibx.ml

CMI			=	$(patsubst %.mli,%.cmi,$(MLI))
CMX			=	$(patsubst %.ml,%.cmx,$(ML))
CMO			=	$(patsubst %.ml,%.cmo,$(ML))
INC_MLX		=	/usr/local/lib

PKG			= -package ctypes.foreign -linkpkg
CLIB		=	-cclib "-Wl,--whole-archive" \
				-cclib -lmlx \
				-cclib -lbsd \
				-cclib "-Wl,--no-whole-archive" \
				-cclib "-Wl,-E" \
				-cclib -lX11 \
				-cclib -lXext

COPT		=	-ccopt -L$(INC_MLX)

ML_EXE		=	test.ml
BYT			=	$(patsubst %.ml,%.byte,$(ML_EXE))
OPT			=	$(patsubst %.ml,%.native,$(ML_EXE))
OBJ_TEST	=	$(patsubst %.ml,test/%.o,$(ML_EXE)) \
				$(patsubst %.ml,test/%.cmi,$(ML_EXE)) \
				$(patsubst %.ml,test/%.cmo,$(ML_EXE)) \
				$(patsubst %.ml,test/%.cmx,$(ML_EXE))

all: $(EXE)

%.cmx:%.ml
	$(CC_OPT) -c $(PKG) $<

%.cmo:%.ml
	$(CC_BYT) -c $(PKG) $<

%.cmi:%.mli
	$(CC_BYT) -c $(PKG) $<

$(BYT): $(CMI) $(CMO)
	$(CC_BYT) $(PKG) $(COPT) $(CLIB) $(CMO) -custom test/$(ML_EXE) -o test/$@

$(OPT): $(CMI) $(CMX)
	$(CC_OPT) -o $@ $(COPT) $(CLIB) $(PKG) $(CMX) test/$(ML_EXE) -o test/$@

clean:
	$(RM) $(CMI) $(CMX) $(CMO)

fclean: clean
	$(RM) test/$(BYT) test/$(OPT) $(OBJ_TEST)

re: fclean all
