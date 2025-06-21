(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var794 0)
(declare-sort var4 0)
(declare-sort var501 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ast/976633046 (var794) var4)
(declare-fun getType/-1564681410 (var794) Int)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var794 var794)
(declare-const null-var4 var4)
(declare-const var501-tokenNames (Array Int String))
(declare-const var1707 var794) ; Statement: r0 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var1707 null-var794)))
(define-const var708 var4 (ast/976633046 var1707)) ; Statement: $r1 = r0.<org.antlr.v4.tool.Grammar: org.antlr.v4.tool.ast.GrammarRootAST ast> 
 ; Statement: if $r1 != null goto $r2 = <org.antlr.v4.parse.ANTLRParser: java.lang.String[] tokenNames> 
(assert (not (= var708 null-var4))) ; Cond: $r1 != null 
(define-const var3712 (Array Int String) var501-tokenNames) ; Statement: $r2 = <org.antlr.v4.parse.ANTLRParser: java.lang.String[] tokenNames> 
(assert true)
(define-const var1954 Int (getType/-1564681410 var1707)) ; Statement: $i0 = virtualinvoke r0.<org.antlr.v4.tool.Grammar: int getType()>() 
(define-const var308 String (select var3712 var1954)) ; Statement: $r3 = $r2[$i0] 
(assert true)
(define-const var545 String (toLowerCase/415700667 var308)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
 ; Statement: return $r4 
(check-sat)
; {ast/976633046=([org.antlr.v4.tool.Grammar], org.antlr.v4.tool.ast.GrammarRootAST), getType/-1564681410=([org.antlr.v4.tool.Grammar], int), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var794=org.antlr.v4.tool.Grammar, var1707=r0, var4=org.antlr.v4.tool.ast.GrammarRootAST, var708=$r1, var501=org.antlr.v4.parse.ANTLRParser, var3712=$r2, var1954=$i0, var308=$r3, var545=$r4}
; {org.antlr.v4.tool.Grammar=var794, r0=var1707, org.antlr.v4.tool.ast.GrammarRootAST=var4, $r1=var708, org.antlr.v4.parse.ANTLRParser=var501, $r2=var3712, $i0=var1954, $r3=var308, $r4=var545}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Grammar;	$r1 = r0.<org.antlr.v4.tool.Grammar: org.antlr.v4.tool.ast.GrammarRootAST ast>;	if $r1 != null goto $r2 = <org.antlr.v4.parse.ANTLRParser: java.lang.String[] tokenNames>;	$r2 = <org.antlr.v4.parse.ANTLRParser: java.lang.String[] tokenNames>;	$i0 = virtualinvoke r0.<org.antlr.v4.tool.Grammar: int getType()>();	$r3 = $r2[$i0];	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	return $r4
;block_num 2