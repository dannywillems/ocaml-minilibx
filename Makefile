#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: dwillems <dwillems@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2016/07/31 06:15:42 by dwillems          #+#    #+#             *#
#*   Updated: 2016/08/27 19:48:47 by dwillems         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#


CC_BYT		=	ocamlc
CC_OPT		=	ocamlopt

LIB_NAME	=	ocaml-minilibx

MLI			=	minilibx.mli
ML			=	minilibx.ml

CMI			=	$(patsubst %.mli,%.cmi,$(MLI))
CMX			=	$(patsubst %.ml,%.cmx,$(ML))
CMO			=	$(patsubst %.ml,%.cmo,$(ML))
OBJ			=	$(patsubst %.ml,%.o,$(ML))
INC_MLX		=	/usr/local/lib

PKG			=	-package ctypes.foreign -linkpkg
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

all: build

build: $(CMI) $(CMO) $(CMX)
	ocamlfind $(CC_BYT) -a -o $(LIB_NAME).cma $(CMO)
	ocamlfind $(CC_OPT) -a -o $(LIB_NAME).cmxa $(CMX)

install: build
	ocamlfind install $(LIB_NAME) META $(LIB_NAME).cma $(LIB_NAME).cmxa $(CMI)

remove:
	ocamlfind remove $(LIB_NAME)

%.cmx:%.ml
	ocamlfind $(CC_OPT) -c $(PKG) $<

%.cmo:%.ml
	ocamlfind $(CC_BYT) -c $(PKG) $<

%.cmi:%.mli
	ocamlfind $(CC_BYT) -c $(PKG) $<

$(BYT): $(CMI) $(CMO)
	ocamlfind $(CC_BYT) $(PKG) $(COPT) $(CLIB) $(CMO) -custom \
		test/$(ML_EXE) -o test/$@

$(OPT): $(CMI) $(CMX)
	ocamlfind $(CC_OPT) -o $@ $(COPT) $(CLIB) $(PKG) $(CMX) \
		test/$(ML_EXE) -o test/$@

clean:
	$(RM) $(CMI) $(CMX) $(CMO) $(OBJ)

fclean: clean
	$(RM) test/$(BYT) test/$(OPT) $(OBJ_TEST)
	$(RM) $(LIB_NAME).cmxa $(LIB_NAME).cma $(LIB_NAME).a

re: fclean all
