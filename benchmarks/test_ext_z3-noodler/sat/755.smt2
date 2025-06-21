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

(declare-sort var2653 0)
(declare-sort var3963 0)
(declare-sort var2273 0)
(declare-sort var1418 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCodeGenerator/1822649198 (var2273) var3963)
(declare-fun cast-from-var2653-to-var2273 (var2653) var2273)
(declare-fun g/229379286 (var3963) var1418)
(declare-fun name/976633046 (var1418) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var2653 var2653)
(declare-const null-Bool Bool)
(declare-const var2653-$assertionsDisabled Bool)
(declare-const var200 var2653) ; Statement: r0 := @this: org.antlr.v4.codegen.target.GoTarget 
(assert (not (= var200 null-var2653)))
(declare-const var112 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var112 null-Bool)))
(assert true)
(define-const var826 var3963 (getCodeGenerator/1822649198 (cast-from-var2653-to-var2273 var200))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var1502 var1418 (g/229379286 var826)) ; Statement: r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var3092 Bool var2653-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert (not (= (ite var3092 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1028 String (name/976633046 var1502)) ; Statement: $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert true)
(define-const var3740 String (toLowerCase/415700667 var1028)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var286 String (str.++ "\u0001_base_visitor.go" var3740)) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_base_visitor.go") 
 ; Statement: return $r5 
(check-sat)
; {getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), cast-from-var2653-to-var2273=([org.antlr.v4.codegen.target.GoTarget], org.antlr.v4.codegen.Target), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), name/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var2653=org.antlr.v4.codegen.target.GoTarget, var200=r0, var112=z1, var3963=org.antlr.v4.codegen.CodeGenerator, var2273=org.antlr.v4.codegen.Target, var826=r1, var1418=org.antlr.v4.tool.Grammar, var1502=r2, var3092=$z0, var1028=$r3, var3740=$r4, var286=$r5}
; {org.antlr.v4.codegen.target.GoTarget=var2653, r0=var200, z1=var112, org.antlr.v4.codegen.CodeGenerator=var3963, org.antlr.v4.codegen.Target=var2273, r1=var826, org.antlr.v4.tool.Grammar=var1418, r2=var1502, $z0=var3092, $r3=var1028, $r4=var3740, $r5=var286}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.GoTarget;	z1 := @parameter0: boolean;	r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	$z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled>;	if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_base_visitor.go");	return $r5
;block_num 2