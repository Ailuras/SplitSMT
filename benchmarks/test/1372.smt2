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

(declare-sort var2619 0)
(declare-sort var1495 0)
(declare-sort var722 0)
(declare-sort var1656 0)
(declare-sort var2833 0)
(declare-sort var991 0)
(declare-sort var2124 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getTemplates/-882175402 (var2619) var722)
(declare-fun getInstanceOf/202174775 (var722 String) var1656)
(declare-fun getCodeGenerator/1822649198 (var2619) var2833)
(declare-fun g/229379286 (var2833) var991)
(declare-fun getTokenType/937835092 (var991 String) Int)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun getTokenTypeAsTargetLabel/-388904022 (var2619 var991 Int) String)
(declare-fun add/-1632356646 (var1656 String var2124) var1656)
(declare-fun cast-from-String-to-var2124 (String) var2124)
(declare-fun render/-1277379482 (var1656) String)
(declare-const null-var2619 var2619)
(declare-const null-String String)
(declare-const var3673 var2619) ; Statement: r0 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var3673 null-var2619)))
(declare-const var3068 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3068 null-String)))
(assert true)
(define-const var2818 var722 (getTemplates/-882175402 var3673)) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.stringtemplate.v4.STGroup getTemplates()>() 
(assert true)
(define-const var522 var1656 (getInstanceOf/202174775 var2818 "ImplicitTokenLabel")) ; Statement: r2 = virtualinvoke $r1.<org.stringtemplate.v4.STGroup: org.stringtemplate.v4.ST getInstanceOf(java.lang.String)>("ImplicitTokenLabel") 
(assert true)
(define-const var2989 var2833 (getCodeGenerator/1822649198 var3673)) ; Statement: $r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var1807 var991 (g/229379286 var2989)) ; Statement: $r5 = $r3.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(assert true)
(define-const var3403 Int (getTokenType/937835092 var1807 var3068)) ; Statement: i0 = virtualinvoke $r5.<org.antlr.v4.tool.Grammar: int getTokenType(java.lang.String)>(r4) 
(assert true)
(define-const var3729 Bool (startsWith/-1785782452 var3068 "\u0027")) ; Statement: $z0 = virtualinvoke r4.<java.lang.String: boolean startsWith(java.lang.String)>("\'") 
 ; Statement: if $z0 == 0 goto $r6 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(assert (= (ite var3729 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2152 var2833 (getCodeGenerator/1822649198 var3673)) ; Statement: $r6 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var3307 var991 (g/229379286 var2152)) ; Statement: $r7 = $r6.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(assert true)
(define-const var1625 String (getTokenTypeAsTargetLabel/-388904022 var3673 var3307 var3403)) ; Statement: r8 = virtualinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String getTokenTypeAsTargetLabel(org.antlr.v4.tool.Grammar,int)>($r7, i0) 
(assert true)
;(assert (add/-1632356646 var522 "tokenName" (cast-from-String-to-var2124 var1625))) ; Statement: virtualinvoke r2.<org.stringtemplate.v4.ST: org.stringtemplate.v4.ST add(java.lang.String,java.lang.Object)>("tokenName", r8) 

(declare-const var522!1 var1656)
(declare-const var1876 String)
(declare-const var1625!1 String)
(assert true)
(define-const var1593 String (render/-1277379482 var522!1)) ; Statement: $r9 = virtualinvoke r2.<org.stringtemplate.v4.ST: java.lang.String render()>() 
 ; Statement: return $r9 
(check-sat)
; {getTemplates/-882175402=([org.antlr.v4.codegen.Target], org.stringtemplate.v4.STGroup), getInstanceOf/202174775=([org.stringtemplate.v4.STGroup, java.lang.String], org.stringtemplate.v4.ST), getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), getTokenType/937835092=([org.antlr.v4.tool.Grammar, java.lang.String], int), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), getTokenTypeAsTargetLabel/-388904022=([org.antlr.v4.codegen.Target, org.antlr.v4.tool.Grammar, int], java.lang.String), add/-1632356646=([org.stringtemplate.v4.ST, java.lang.String, java.lang.Object], org.stringtemplate.v4.ST), cast-from-String-to-var2124=([java.lang.String], java.lang.Object), render/-1277379482=([org.stringtemplate.v4.ST], java.lang.String)}
; {var2619=org.antlr.v4.codegen.Target, var3673=r0, var3068=r4, var1495=null_type, var722=org.stringtemplate.v4.STGroup, var2818=$r1, var1656=org.stringtemplate.v4.ST, var522=r2, var2833=org.antlr.v4.codegen.CodeGenerator, var2989=$r3, var991=org.antlr.v4.tool.Grammar, var1807=$r5, var3403=i0, var3729=$z0, var2152=$r6, var3307=$r7, var1625=r8, var2124=java.lang.Object, var1876="tokenName", var1593=$r9}
; {org.antlr.v4.codegen.Target=var2619, r0=var3673, r4=var3068, null_type=var1495, org.stringtemplate.v4.STGroup=var722, $r1=var2818, org.stringtemplate.v4.ST=var1656, r2=var522, org.antlr.v4.codegen.CodeGenerator=var2833, $r3=var2989, org.antlr.v4.tool.Grammar=var991, $r5=var1807, i0=var3403, $z0=var3729, $r6=var2152, $r7=var3307, r8=var1625, java.lang.Object=var2124, "tokenName"=var1876, $r9=var1593}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.Target;	r4 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.stringtemplate.v4.STGroup getTemplates()>();	r2 = virtualinvoke $r1.<org.stringtemplate.v4.STGroup: org.stringtemplate.v4.ST getInstanceOf(java.lang.String)>("ImplicitTokenLabel");	$r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	$r5 = $r3.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	i0 = virtualinvoke $r5.<org.antlr.v4.tool.Grammar: int getTokenType(java.lang.String)>(r4);	$z0 = virtualinvoke r4.<java.lang.String: boolean startsWith(java.lang.String)>("\'");	if $z0 == 0 goto $r6 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	$r6 = virtualinvoke r0.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	$r7 = $r6.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	r8 = virtualinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String getTokenTypeAsTargetLabel(org.antlr.v4.tool.Grammar,int)>($r7, i0);	virtualinvoke r2.<org.stringtemplate.v4.ST: org.stringtemplate.v4.ST add(java.lang.String,java.lang.Object)>("tokenName", r8);	$r9 = virtualinvoke r2.<org.stringtemplate.v4.ST: java.lang.String render()>();	return $r9
;block_num 2