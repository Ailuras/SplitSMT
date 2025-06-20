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

(declare-sort var426 0)
(declare-sort var2625 0)
(declare-sort var3924 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun key/-413538537 (var426) var2625)
(declare-fun append/-1031950772 (String var2625) String)
(declare-fun value/-413538537 (var426) var2625)
(declare-fun lastAccessTime/-413538537 (var426) var3924)
(declare-fun cast-from-var3924-to-var2625 (var3924) var2625)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var426 var426)
(declare-const var489 var426) ; Statement: r1 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject 
(assert (not (= var489 null-var426)))
(define-const var44 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var44)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var44!1 String)
(assert (= var44!1 ""))
(assert true)
(define-const var440 String (append/672562846 var44!1 "ExpiryObject{key=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpiryObject{key=") 
(declare-const var44!2 String)
(assert (= var44!2 (str.++ var44!1 "ExpiryObject{key=")))
(define-const var551 var2625 (key/-413538537 var489)) ; Statement: $r2 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject: java.lang.Object key> 
(assert true)
(define-const var2920 String (append/-1031950772 var440 var551)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var440!1 String)
(assert (str.prefixof var440 var440!1))
(assert true)
(define-const var2048 String (append/672562846 var2920 ", value=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", value=") 
(declare-const var2920!1 String)
(assert (= var2920!1 (str.++ var2920 ", value=")))
(define-const var2750 var2625 (value/-413538537 var489)) ; Statement: $r5 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject: java.lang.Object value> 
(assert true)
(define-const var1686 String (append/-1031950772 var2048 var2750)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2048!1 String)
(assert (str.prefixof var2048 var2048!1))
(assert true)
(define-const var1940 String (append/672562846 var1686 ", lastAccessTime=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", lastAccessTime=") 
(declare-const var1686!1 String)
(assert (= var1686!1 (str.++ var1686 ", lastAccessTime=")))
(define-const var2981 var3924 (lastAccessTime/-413538537 var489)) ; Statement: $r8 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject: java.util.concurrent.atomic.AtomicLong lastAccessTime> 
(assert true)
(define-const var1813 String (append/-1031950772 var1940 (cast-from-var3924-to-var2625 var2981))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var1940!1 String)
(assert (str.prefixof var1940 var1940!1))
(assert true)
(define-const var113 String (append/-1166366385 var1813 125)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1813!1 String)
(assert (str.prefixof var1813 var1813!1))
(assert true)
(define-const var1525 String (toString/-2075883882 var113)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), key/-413538537=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), value/-413538537=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject], java.lang.Object), lastAccessTime/-413538537=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject], java.util.concurrent.atomic.AtomicLong), cast-from-var3924-to-var2625=([java.util.concurrent.atomic.AtomicLong], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var426=org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject, var489=r1, var44=$r0, var440=$r3, var2625=java.lang.Object, var551=$r2, var2920=$r4, var2048=$r6, var2750=$r5, var1686=$r7, var1940=$r9, var3924=java.util.concurrent.atomic.AtomicLong, var2981=$r8, var1813=$r10, var113=$r11, var1525=$r12}
; {org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject=var426, r1=var489, $r0=var44, $r3=var440, java.lang.Object=var2625, $r2=var551, $r4=var2920, $r6=var2048, $r5=var2750, $r7=var1686, $r9=var1940, java.util.concurrent.atomic.AtomicLong=var3924, $r8=var2981, $r10=var1813, $r11=var113, $r12=var1525}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpiryObject{key=");	$r2 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject: java.lang.Object key>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", value=");	$r5 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject: java.lang.Object value>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", lastAccessTime=");	$r8 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpiryObject: java.util.concurrent.atomic.AtomicLong lastAccessTime>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1