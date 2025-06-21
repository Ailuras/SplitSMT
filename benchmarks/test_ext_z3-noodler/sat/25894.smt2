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

(declare-sort var1089 0)
(declare-sort var384 0)
(declare-sort var385 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun element/1454718025 (var1089) var384)
(declare-fun append/-1031950772 (String var385) String)
(declare-fun cast-from-var384-to-var385 (var384) var385)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1089 var1089)
(declare-const var50 var1089) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta 
(assert (not (= var50 null-var1089)))
(define-const var1762 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1762)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1762!1 String)
(assert (= var1762!1 ""))
(assert true)
(define-const var3469 String (append/672562846 var1762!1 "Stream parameter [")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Stream parameter [") 
(declare-const var1762!2 String)
(assert (= var1762!2 (str.++ var1762!1 "Stream parameter [")))
(define-const var1216 var384 (element/1454718025 var50)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta: java.lang.reflect.AnnotatedElement element> 
(assert true)
(define-const var561 String (append/-1031950772 var3469 (cast-from-var384-to-var385 var1216))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3469!1 String)
(assert (str.prefixof var3469 var3469!1))
(assert true)
(define-const var2806 String (append/672562846 var561 "]")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var561!1 String)
(assert (= var561!1 (str.++ var561 "]")))
(assert true)
(define-const var945 String (toString/-2075883882 var2806)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), element/1454718025=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta], java.lang.reflect.AnnotatedElement), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var384-to-var385=([java.lang.reflect.AnnotatedElement], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1089=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta, var50=r1, var1762=$r0, var3469=$r3, var384=java.lang.reflect.AnnotatedElement, var1216=$r2, var385=java.lang.Object, var561=$r4, var2806=$r5, var945=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta=var1089, r1=var50, $r0=var1762, $r3=var3469, java.lang.reflect.AnnotatedElement=var384, $r2=var1216, java.lang.Object=var385, $r4=var561, $r5=var2806, $r6=var945}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Stream parameter [");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta$StreamParameterMeta: java.lang.reflect.AnnotatedElement element>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1