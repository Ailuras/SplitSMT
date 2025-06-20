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

(declare-sort var3905 0)
(declare-sort var823 0)
(declare-sort var2766 0)
(declare-sort var2353 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCodeGenerator/1822649198 (var2766) var823)
(declare-fun cast-from-var3905-to-var2766 (var3905) var2766)
(declare-fun g/229379286 (var823) var2353)
(declare-fun getType/-1564681410 (var2353) Int)
(declare-fun name/976633046 (var2353) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var3905 var3905)
(declare-const null-Bool Bool)
(declare-const var3905-$assertionsDisabled Bool)
(declare-const var1558 var3905) ; Statement: r0 := @this: org.antlr.v4.codegen.target.GoTarget 
(assert (not (= var1558 null-var3905)))
(declare-const var733 Bool) ; Statement: z3 := @parameter0: boolean 
(assert (not (= var733 null-Bool)))
(assert true)
(define-const var1698 var823 (getCodeGenerator/1822649198 (cast-from-var3905-to-var2766 var1558))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var2605 var2353 (g/229379286 var1698)) ; Statement: r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var702 Bool var3905-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>() 
(assert (not (= (ite var702 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var491 Int (getType/-1564681410 var2605)) ; Statement: $i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>() 
 ; Statement: lookupswitch($i0) {     case 31: goto $r11 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 44: goto $r6 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 72: goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     default: goto return "INVALID_FILE_NAME"; } 
(assert (and (= var491 72) (and (not (= var491 44)) (and (not (= var491 31)) true)))) ; Intersect: Cond: $i0 == 72  and Intersect: Negate: Cond: $i0 == 44   and Intersect: Negate: Cond: $i0 == 31   and Non Conditional   
(define-const var2826 String (name/976633046 var2605)) ; Statement: $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert true)
(define-const var1030 String (toLowerCase/415700667 var2826)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var3058 String (str.++ "\u0001_parser.go" var1030)) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_parser.go") 
 ; Statement: return $r5 
(check-sat)
; {getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), cast-from-var3905-to-var2766=([org.antlr.v4.codegen.target.GoTarget], org.antlr.v4.codegen.Target), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), getType/-1564681410=([org.antlr.v4.tool.Grammar], int), name/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var3905=org.antlr.v4.codegen.target.GoTarget, var1558=r0, var733=z3, var823=org.antlr.v4.codegen.CodeGenerator, var2766=org.antlr.v4.codegen.Target, var1698=r1, var2353=org.antlr.v4.tool.Grammar, var2605=r2, var702=$z0, var491=$i0, var2826=$r3, var1030=$r4, var3058=$r5}
; {org.antlr.v4.codegen.target.GoTarget=var3905, r0=var1558, z3=var733, org.antlr.v4.codegen.CodeGenerator=var823, org.antlr.v4.codegen.Target=var2766, r1=var1698, org.antlr.v4.tool.Grammar=var2353, r2=var2605, $z0=var702, $i0=var491, $r3=var2826, $r4=var1030, $r5=var3058}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.GoTarget;	z3 := @parameter0: boolean;	r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	$z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled>;	if $z0 != 0 goto $i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>();	$i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>();	lookupswitch($i0) {     case 31: goto $r11 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 44: goto $r6 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 72: goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     default: goto return "INVALID_FILE_NAME"; };	$r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>($r4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001_parser.go");	return $r5
;block_num 3