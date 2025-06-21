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

(declare-sort var13 0)
(declare-sort var3290 0)
(declare-sort var978 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun method/-632954190 (var13) var3290)
(declare-fun append/-1031950772 (String var978) String)
(declare-fun cast-from-var3290-to-var978 (var3290) var978)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var13 var13)
(declare-const var3108 var13) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta 
(assert (not (= var3108 null-var13)))
(define-const var1320 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1320)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1320!1 String)
(assert (= var1320!1 ""))
(assert true)
(define-const var3039 String (append/672562846 var1320!1 "SetMethodParameter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SetMethodParameter{") 
(declare-const var1320!2 String)
(assert (= var1320!2 (str.++ var1320!1 "SetMethodParameter{")))
(define-const var2430 var3290 (method/-632954190 var3108)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta: java.lang.reflect.Method method> 
(assert true)
(define-const var2301 String (append/-1031950772 var3039 (cast-from-var3290-to-var978 var2430))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3039!1 String)
(assert (str.prefixof var3039 var3039!1))
(assert true)
(define-const var576 String (append/-1166366385 var2301 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2301!1 String)
(assert (str.prefixof var2301 var2301!1))
(assert true)
(define-const var108 String (toString/-2075883882 var576)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), method/-632954190=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta], java.lang.reflect.Method), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3290-to-var978=([java.lang.reflect.Method], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var13=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta, var3108=r1, var1320=$r0, var3039=$r3, var3290=java.lang.reflect.Method, var2430=$r2, var978=java.lang.Object, var2301=$r4, var576=$r5, var108=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta=var13, r1=var3108, $r0=var1320, $r3=var3039, java.lang.reflect.Method=var3290, $r2=var2430, java.lang.Object=var978, $r4=var2301, $r5=var576, $r6=var108}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SetMethodParameter{");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$SetMethodMeta: java.lang.reflect.Method method>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1