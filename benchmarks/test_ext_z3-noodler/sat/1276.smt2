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

(declare-sort var2048 0)
(declare-sort var3113 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toString/75501439 (var3113) String)
(declare-fun cast-from-var2048-to-var3113 (var2048) var3113)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun protocol/1567270623 (var2048) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2048 var2048)
(declare-const var169 var2048) ; Statement: r1 := @this: org.apache.dubbo.common.ProtocolServiceKey 
(assert (not (= var169 null-var2048)))
(define-const var491 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var491)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var491!1 String)
(assert (= var491!1 ""))
(assert true)
(define-const var1056 String (toString/75501439 (cast-from-var2048-to-var3113 var169))) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.common.ServiceKey: java.lang.String toString()>() 
(assert true)
(define-const var2663 String (append/672562846 var491!1 var1056)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var491!2 String)
(assert (= var491!2 (str.++ var491!1 var1056)))
(assert true)
(define-const var2971 String (append/672562846 var2663 ":")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var2663!1 String)
(assert (= var2663!1 (str.++ var2663 ":")))
(define-const var3202 String (protocol/1567270623 var169)) ; Statement: $r4 = r1.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String protocol> 
(assert true)
(define-const var1255 String (append/672562846 var2971 var3202)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2971!1 String)
(assert (= var2971!1 (str.++ var2971 var3202)))
(assert true)
(define-const var261 String (toString/-2075883882 var1255)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toString/75501439=([org.apache.dubbo.common.ServiceKey], java.lang.String), cast-from-var2048-to-var3113=([org.apache.dubbo.common.ProtocolServiceKey], org.apache.dubbo.common.ServiceKey), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), protocol/1567270623=([org.apache.dubbo.common.ProtocolServiceKey], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2048=org.apache.dubbo.common.ProtocolServiceKey, var169=r1, var491=$r0, var3113=org.apache.dubbo.common.ServiceKey, var1056=$r2, var2663=$r3, var2971=$r5, var3202=$r4, var1255=$r6, var261=$r7}
; {org.apache.dubbo.common.ProtocolServiceKey=var2048, r1=var169, $r0=var491, org.apache.dubbo.common.ServiceKey=var3113, $r2=var1056, $r3=var2663, $r5=var2971, $r4=var3202, $r6=var1255, $r7=var261}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.ServiceKey: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.ProtocolServiceKey;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = specialinvoke r1.<org.apache.dubbo.common.ServiceKey: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r4 = r1.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String protocol>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1