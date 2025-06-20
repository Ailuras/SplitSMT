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

(declare-sort var1991 0)
(declare-sort var2486 0)
(declare-sort var2464 0)
(declare-sort var3863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCodeGenerator/1822649198 (var2464) var2486)
(declare-fun cast-from-var1991-to-var2464 (var1991) var2464)
(declare-fun g/229379286 (var2486) var3863)
(declare-fun name/976633046 (var3863) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var1991 var1991)
(declare-const null-Bool Bool)
(declare-const var1991-$assertionsDisabled Bool)
(declare-const var540 var1991) ; Statement: r0 := @this: org.antlr.v4.codegen.target.GoTarget 
(assert (not (= var540 null-var1991)))
(declare-const var1884 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var1884 null-Bool)))
(assert true)
(define-const var543 var2486 (getCodeGenerator/1822649198 (cast-from-var1991-to-var2464 var540))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var1986 var3863 (g/229379286 var543)) ; Statement: r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var400 Bool var1991-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert (not (= (ite var400 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3723 String (name/976633046 var1986)) ; Statement: $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert true)
(define-const var2036 String (toLowerCase/415700667 var3723)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var2475 String (str.++ "\u0001_base_listener.go" var2036)) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_base_listener.go") 
 ; Statement: return $r5 
(check-sat)
; {getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), cast-from-var1991-to-var2464=([org.antlr.v4.codegen.target.GoTarget], org.antlr.v4.codegen.Target), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), name/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var1991=org.antlr.v4.codegen.target.GoTarget, var540=r0, var1884=z1, var2486=org.antlr.v4.codegen.CodeGenerator, var2464=org.antlr.v4.codegen.Target, var543=r1, var3863=org.antlr.v4.tool.Grammar, var1986=r2, var400=$z0, var3723=$r3, var2036=$r4, var2475=$r5}
; {org.antlr.v4.codegen.target.GoTarget=var1991, r0=var540, z1=var1884, org.antlr.v4.codegen.CodeGenerator=var2486, org.antlr.v4.codegen.Target=var2464, r1=var543, org.antlr.v4.tool.Grammar=var3863, r2=var1986, $z0=var400, $r3=var3723, $r4=var2036, $r5=var2475}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.GoTarget;	z1 := @parameter0: boolean;	r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	$z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled>;	if $z0 != 0 goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_base_listener.go");	return $r5
;block_num 2