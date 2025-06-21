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

(declare-sort var2933 0)
(declare-sort var3577 0)
(declare-sort var2434 0)
(declare-sort var2799 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCodeGenerator/1822649198 (var2434) var3577)
(declare-fun cast-from-var2933-to-var2434 (var2933) var2434)
(declare-fun g/229379286 (var3577) var2799)
(declare-fun name/976633046 (var2799) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var2933 var2933)
(declare-const null-Bool Bool)
(declare-const var2933-$assertionsDisabled Bool)
(declare-const var3250 var2933) ; Statement: r0 := @this: org.antlr.v4.codegen.target.GoTarget 
(assert (not (= var3250 null-var2933)))
(declare-const var2275 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var2275 null-Bool)))
(assert true)
(define-const var1669 var3577 (getCodeGenerator/1822649198 (cast-from-var2933-to-var2434 var3250))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var2597 var2799 (g/229379286 var1669)) ; Statement: r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var528 Bool var2933-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert (not (= (ite var528 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1955 String (name/976633046 var2597)) ; Statement: $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert true)
(define-const var2879 String (toLowerCase/415700667 var1955)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var3498 String (str.++ "\u0001_visitor.go" var2879)) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_visitor.go") 
 ; Statement: return $r5 
(check-sat)
; {getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), cast-from-var2933-to-var2434=([org.antlr.v4.codegen.target.GoTarget], org.antlr.v4.codegen.Target), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), name/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var2933=org.antlr.v4.codegen.target.GoTarget, var3250=r0, var2275=z1, var3577=org.antlr.v4.codegen.CodeGenerator, var2434=org.antlr.v4.codegen.Target, var1669=r1, var2799=org.antlr.v4.tool.Grammar, var2597=r2, var528=$z0, var1955=$r3, var2879=$r4, var3498=$r5}
; {org.antlr.v4.codegen.target.GoTarget=var2933, r0=var3250, z1=var2275, org.antlr.v4.codegen.CodeGenerator=var3577, org.antlr.v4.codegen.Target=var2434, r1=var1669, org.antlr.v4.tool.Grammar=var2799, r2=var2597, $z0=var528, $r3=var1955, $r4=var2879, $r5=var3498}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.GoTarget;	z1 := @parameter0: boolean;	r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	$z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled>;	if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_visitor.go");	return $r5
;block_num 2