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

(declare-sort var2481 0)
(declare-sort var1827 0)
(declare-sort var320 0)
(declare-sort var3943 0)
(declare-sort var3922 0)
(declare-sort var2293 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getTemplates/-882175402 (var2481) var320)
(declare-fun getInstanceOf/202174775 (var320 String) var3943)
(declare-fun getCodeGenerator/1822649198 (var2481) var3922)
(declare-fun g/229379286 (var3922) var2293)
(declare-fun getTokenType/937835092 (var2293 String) Int)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun cast-from-Int-to-String (Int) String)
(declare-const null-var2481 var2481)
(declare-const null-String String)
(declare-const var1004 var2481) ; Statement: r0 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var1004 null-var2481)))
(declare-const var1676 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var1676 null-String)))
(assert true)
(define-const var3043 var320 (getTemplates/-882175402 var1004)) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.stringtemplate.v4.STGroup getTemplates()>() 
(assert true)
(define-const var269 var3943 (getInstanceOf/202174775 var3043 "ImplicitTokenLabel")) ; Statement: r2 = virtualinvoke $r1.<org.stringtemplate.v4.STGroup: org.stringtemplate.v4.ST getInstanceOf(java.lang.String)>("ImplicitTokenLabel") 
(assert true)
(define-const var1864 var3922 (getCodeGenerator/1822649198 var1004)) ; Statement: $r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var1838 var2293 (g/229379286 var1864)) ; Statement: $r5 = $r3.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(assert true)
(define-const var1695 Int (getTokenType/937835092 var1838 var1676)) ; Statement: i0 = virtualinvoke $r5.<org.antlr.v4.tool.Grammar: int getTokenType(java.lang.String)>(r4) 
(assert true)
(define-const var2333 Bool (startsWith/-1785782452 var1676 "\u0027")) ; Statement: $z0 = virtualinvoke r4.<java.lang.String: boolean startsWith(java.lang.String)>("\'") 
 ; Statement: if $z0 == 0 goto $r6 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(assert (not (= (ite var2333 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3448 String (str.++ "s\u0001" (cast-from-Int-to-String var1695))) ; Statement: $r10 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int)>(i0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("s\u0001") 
 ; Statement: return $r10 
(check-sat)
; {getTemplates/-882175402=([org.antlr.v4.codegen.Target], org.stringtemplate.v4.STGroup), getInstanceOf/202174775=([org.stringtemplate.v4.STGroup, java.lang.String], org.stringtemplate.v4.ST), getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), getTokenType/937835092=([org.antlr.v4.tool.Grammar, java.lang.String], int), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), cast-from-Int-to-String=([int], java.lang.String)}
; {var2481=org.antlr.v4.codegen.Target, var1004=r0, var1676=r4, var1827=null_type, var320=org.stringtemplate.v4.STGroup, var3043=$r1, var3943=org.stringtemplate.v4.ST, var269=r2, var3922=org.antlr.v4.codegen.CodeGenerator, var1864=$r3, var2293=org.antlr.v4.tool.Grammar, var1838=$r5, var1695=i0, var2333=$z0, var3448=$r10}
; {org.antlr.v4.codegen.Target=var2481, r0=var1004, r4=var1676, null_type=var1827, org.stringtemplate.v4.STGroup=var320, $r1=var3043, org.stringtemplate.v4.ST=var3943, r2=var269, org.antlr.v4.codegen.CodeGenerator=var3922, $r3=var1864, org.antlr.v4.tool.Grammar=var2293, $r5=var1838, i0=var1695, $z0=var2333, $r10=var3448}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.Target;	r4 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.stringtemplate.v4.STGroup getTemplates()>();	r2 = virtualinvoke $r1.<org.stringtemplate.v4.STGroup: org.stringtemplate.v4.ST getInstanceOf(java.lang.String)>("ImplicitTokenLabel");	$r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	$r5 = $r3.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	i0 = virtualinvoke $r5.<org.antlr.v4.tool.Grammar: int getTokenType(java.lang.String)>(r4);	$z0 = virtualinvoke r4.<java.lang.String: boolean startsWith(java.lang.String)>("\'");	if $z0 == 0 goto $r6 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	$r10 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int)>(i0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("s\u0001");	return $r10
;block_num 2