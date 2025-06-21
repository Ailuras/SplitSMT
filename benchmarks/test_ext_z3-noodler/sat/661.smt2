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

(declare-sort var3711 0)
(declare-sort var700 0)
(declare-sort var342 0)
(declare-sort var3378 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCodeGenerator/1822649198 (var342) var700)
(declare-fun cast-from-var3711-to-var342 (var3711) var342)
(declare-fun g/229379286 (var700) var3378)
(declare-fun name/976633046 (var3378) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var3711 var3711)
(declare-const null-Bool Bool)
(declare-const var3711-$assertionsDisabled Bool)
(declare-const var2142 var3711) ; Statement: r0 := @this: org.antlr.v4.codegen.target.GoTarget 
(assert (not (= var2142 null-var3711)))
(declare-const var3251 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var3251 null-Bool)))
(assert true)
(define-const var3760 var700 (getCodeGenerator/1822649198 (cast-from-var3711-to-var342 var2142))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var1920 var3378 (g/229379286 var3760)) ; Statement: r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var224 Bool var3711-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert (not (= (ite var224 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3149 String (name/976633046 var1920)) ; Statement: $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert true)
(define-const var2143 String (toLowerCase/415700667 var3149)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var2676 String (str.++ "\u0001_listener.go" var2143)) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_listener.go") 
 ; Statement: return $r5 
(check-sat)
; {getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), cast-from-var3711-to-var342=([org.antlr.v4.codegen.target.GoTarget], org.antlr.v4.codegen.Target), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), name/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var3711=org.antlr.v4.codegen.target.GoTarget, var2142=r0, var3251=z1, var700=org.antlr.v4.codegen.CodeGenerator, var342=org.antlr.v4.codegen.Target, var3760=r1, var3378=org.antlr.v4.tool.Grammar, var1920=r2, var224=$z0, var3149=$r3, var2143=$r4, var2676=$r5}
; {org.antlr.v4.codegen.target.GoTarget=var3711, r0=var2142, z1=var3251, org.antlr.v4.codegen.CodeGenerator=var700, org.antlr.v4.codegen.Target=var342, r1=var3760, org.antlr.v4.tool.Grammar=var3378, r2=var1920, $z0=var224, $r3=var3149, $r4=var2143, $r5=var2676}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.GoTarget;	z1 := @parameter0: boolean;	r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	$z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled>;	if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_listener.go");	return $r5
;block_num 2