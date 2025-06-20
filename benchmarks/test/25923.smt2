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

(declare-sort var3521 0)
(declare-sort var2840 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun genericType/955514290 (var3521) ClassObject)
(declare-fun append/-1031950772 (String var2840) String)
(declare-fun cast-from-ClassObject-to-var2840 (ClassObject) var2840)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3521 var3521)
(declare-const null-ClassObject ClassObject)
(declare-const var2240 var3521) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta 
(assert (not (= var2240 null-var3521)))
(define-const var3913 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3913)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3913!1 String)
(assert (= var3913!1 ""))
(assert true)
(define-const var1619 String (append/672562846 var3913!1 "NestedParameter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NestedParameter{") 
(declare-const var3913!2 String)
(assert (= var3913!2 (str.++ var3913!1 "NestedParameter{")))
(define-const var809 ClassObject (genericType/955514290 var2240)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType> 
 ; Statement: if $r2 != null goto $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType> 
(assert (not (= var809 null-ClassObject))) ; Cond: $r2 != null 
(define-const var691 ClassObject (genericType/955514290 var2240)) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType> 
(assert true) ; Non Conditional
(assert true)
(define-const var2227 String (append/-1031950772 var1619 (cast-from-ClassObject-to-var2840 var691))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var1619!1 String)
(assert (str.prefixof var1619 var1619!1))
(assert true)
(define-const var526 String (append/-1166366385 var2227 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2227!1 String)
(assert (str.prefixof var2227 var2227!1))
(assert true)
(define-const var3553 String (toString/-2075883882 var526)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), genericType/955514290=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta], java.lang.reflect.Type), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2840=([java.lang.reflect.Type], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3521=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta, var2240=r1, var3913=$r0, var1619=$r3, var809=$r2, var691=$r7, var2840=java.lang.Object, var2227=$r4, var526=$r5, var3553=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta=var3521, r1=var2240, $r0=var3913, $r3=var1619, $r2=var809, $r7=var691, java.lang.Object=var2840, $r4=var2227, $r5=var526, $r6=var3553}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NestedParameter{");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType>;	if $r2 != null goto $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType>;	$r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3