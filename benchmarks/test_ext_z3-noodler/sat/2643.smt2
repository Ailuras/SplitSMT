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

(declare-sort var1645 0)
(declare-sort var622 0)
(declare-sort var3549 0)
(declare-sort var3951 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3951!class ClassObject)
(declare-fun getAnnotation/-287905434 (var622 ClassObject) var3549)
(declare-fun cast-from-var3549-to-var3951 (var3549) var3951)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun generateUnsupported/-312383508 (var1645 var622) String)
(declare-const null-var1645 var1645)
(declare-const null-var622 var622)
(declare-const null-var3951 var3951)
(declare-const var3793 var1645) ; Statement: r4 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var3793 null-var1645)))
(declare-const var2116 var622) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2116 null-var622)))
(assert true)
(define-const var541 var3549 (getAnnotation/-287905434 var2116 var3951!class)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/Adaptive;") 
(define-const var3499 var3951 (cast-from-var3549-to-var3951 var541)) ; Statement: r2 = (org.apache.dubbo.common.extension.Adaptive) $r1 
(define-const var3309 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var3309 512)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>(int)>(512) 

(declare-const var3309!1 String)
(declare-const var3856 Int)
 ; Statement: if r2 != null goto i0 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: int getUrlTypeIndex(java.lang.reflect.Method)>(r0) 
(assert (not (not (= var3499 null-var3951)))) ; Negate: Cond: r2 != null  
(assert true)
(define-const var778 String (generateUnsupported/-312383508 var3793 var2116)) ; Statement: $r15 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateUnsupported(java.lang.reflect.Method)>(r0) 
 ; Statement: return $r15 
(check-sat)
; {getAnnotation/-287905434=([java.lang.reflect.Method, java.lang.Class], java.lang.annotation.Annotation), cast-from-var3549-to-var3951=([java.lang.annotation.Annotation], org.apache.dubbo.common.extension.Adaptive), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), generateUnsupported/-312383508=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, java.lang.reflect.Method], java.lang.String)}
; {var1645=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var3793=r4, var622=java.lang.reflect.Method, var2116=r0, var3549=java.lang.annotation.Annotation, var3951=org.apache.dubbo.common.extension.Adaptive, var541=$r1, var3499=r2, var3309=$r16, var3856=512, var778=$r15}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var1645, r4=var3793, java.lang.reflect.Method=var622, r0=var2116, java.lang.annotation.Annotation=var3549, org.apache.dubbo.common.extension.Adaptive=var3951, $r1=var541, r2=var3499, $r16=var3309, 512=var3856, $r15=var778}
;seq <java.lang.StringBuilder: void <init>(int)>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/Adaptive;");	r2 = (org.apache.dubbo.common.extension.Adaptive) $r1;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>(int)>(512);	if r2 != null goto i0 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: int getUrlTypeIndex(java.lang.reflect.Method)>(r0);	$r15 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateUnsupported(java.lang.reflect.Method)>(r0);	return $r15
;block_num 2