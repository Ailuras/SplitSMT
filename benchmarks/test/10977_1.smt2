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

(declare-sort var2974 0)
(declare-sort var704 0)
(declare-sort var3741 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun delegateMap/1264481247 (var2974) var704)
(declare-fun toString/1371530584 (var704) String)
(declare-fun expireThread/1264481247 (var2974) var3741)
(declare-fun toString/-2127369754 (var3741) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2974 var2974)
(declare-const var1891 var2974) ; Statement: r1 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap 
(assert (not (= var1891 null-var2974)))
(define-const var2485 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2485)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2485!1 String)
(assert (= var2485!1 ""))
(assert true)
(define-const var1384 String (append/672562846 var2485!1 "ExpiringMap{delegateMap=")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpiringMap{delegateMap=") 
(declare-const var2485!2 String)
(assert (= var2485!2 (str.++ var2485!1 "ExpiringMap{delegateMap=")))
(define-const var1364 var704 (delegateMap/1264481247 var1891)) ; Statement: $r2 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap: java.util.concurrent.ConcurrentHashMap delegateMap> 
(assert true)
(define-const var798 String (toString/1371530584 var1364)) ; Statement: $r3 = virtualinvoke $r2.<java.util.concurrent.ConcurrentHashMap: java.lang.String toString()>() 
(assert true)
(define-const var3663 String (append/672562846 var1384 var798)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1384!1 String)
(assert (= var1384!1 (str.++ var1384 var798)))
(assert true)
(define-const var232 String (append/672562846 var3663 ", expireThread=")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", expireThread=") 
(declare-const var3663!1 String)
(assert (= var3663!1 (str.++ var3663 ", expireThread=")))
(define-const var3107 var3741 (expireThread/1264481247 var1891)) ; Statement: $r6 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread expireThread> 
(assert true)
(define-const var2434 String (toString/-2127369754 var3107)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.String toString()>() 
(assert true)
(define-const var837 String (append/672562846 var232 var2434)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var232!1 String)
(assert (= var232!1 (str.++ var232 var2434)))
(assert true)
(define-const var3887 String (append/-1166366385 var837 125)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var837!1 String)
(assert (str.prefixof var837 var837!1))
(assert true)
(define-const var1138 String (toString/-2075883882 var3887)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), delegateMap/1264481247=([org.apache.dubbo.cache.support.expiring.ExpiringMap], java.util.concurrent.ConcurrentHashMap), toString/1371530584=([java.util.concurrent.ConcurrentHashMap], java.lang.String), expireThread/1264481247=([org.apache.dubbo.cache.support.expiring.ExpiringMap], org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread), toString/-2127369754=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2974=org.apache.dubbo.cache.support.expiring.ExpiringMap, var1891=r1, var2485=$r0, var1384=$r4, var704=java.util.concurrent.ConcurrentHashMap, var1364=$r2, var798=$r3, var3663=$r5, var232=$r8, var3741=org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread, var3107=$r6, var2434=$r7, var837=$r9, var3887=$r10, var1138=$r11}
; {org.apache.dubbo.cache.support.expiring.ExpiringMap=var2974, r1=var1891, $r0=var2485, $r4=var1384, java.util.concurrent.ConcurrentHashMap=var704, $r2=var1364, $r3=var798, $r5=var3663, $r8=var232, org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread=var3741, $r6=var3107, $r7=var2434, $r9=var837, $r10=var3887, $r11=var1138}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.concurrent.ConcurrentHashMap: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpiringMap{delegateMap=");	$r2 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap: java.util.concurrent.ConcurrentHashMap delegateMap>;	$r3 = virtualinvoke $r2.<java.util.concurrent.ConcurrentHashMap: java.lang.String toString()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", expireThread=");	$r6 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread expireThread>;	$r7 = virtualinvoke $r6.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.String toString()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1