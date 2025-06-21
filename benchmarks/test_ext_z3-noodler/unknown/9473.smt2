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

(declare-sort var2986 0)
(declare-sort var1176 0)
(declare-sort var285 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun timeToLiveMillis/-834817842 (var2986) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun expirationIntervalMillis/-834817842 (var2986) Int)
(declare-fun running/-834817842 (var2986) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun expirerThread/-834817842 (var2986) var1176)
(declare-fun append/-1031950772 (String var285) String)
(declare-fun cast-from-var1176-to-var285 (var1176) var285)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2986 var2986)
(declare-const var1761 var2986) ; Statement: r1 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread 
(assert (not (= var1761 null-var2986)))
(define-const var1679 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1679)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1679!1 String)
(assert (= var1679!1 ""))
(assert true)
(define-const var3604 String (append/672562846 var1679!1 "ExpireThread{, timeToLiveMillis=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpireThread{, timeToLiveMillis=") 
(declare-const var1679!2 String)
(assert (= var1679!2 (str.++ var1679!1 "ExpireThread{, timeToLiveMillis=")))
(define-const var3804 Int (timeToLiveMillis/-834817842 var1761)) ; Statement: $l0 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: long timeToLiveMillis> 
(assert true)
(define-const var3244 String (append/-901862667 var3604 var3804)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var3604!1 String)
(assert (str.prefixof var3604 var3604!1))
(assert true)
(define-const var3360 String (append/672562846 var3244 ", expirationIntervalMillis=")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", expirationIntervalMillis=") 
(declare-const var3244!1 String)
(assert (= var3244!1 (str.++ var3244 ", expirationIntervalMillis=")))
(define-const var2481 Int (expirationIntervalMillis/-834817842 var1761)) ; Statement: $l1 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: long expirationIntervalMillis> 
(assert true)
(define-const var1686 String (append/-901862667 var3360 var2481)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l1) 
(declare-const var3360!1 String)
(assert (str.prefixof var3360 var3360!1))
(assert true)
(define-const var407 String (append/672562846 var1686 ", running=")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", running=") 
(declare-const var1686!1 String)
(assert (= var1686!1 (str.++ var1686 ", running=")))
(define-const var3557 Bool (running/-834817842 var1761)) ; Statement: $z0 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: boolean running> 
(assert true)
(define-const var781 String (append/-388390247 var407 var3557)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var407!1 String)
(assert (str.prefixof var407 var407!1))
(assert true)
(define-const var631 String (append/672562846 var781 ", expirerThread=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", expirerThread=") 
(declare-const var781!1 String)
(assert (= var781!1 (str.++ var781 ", expirerThread=")))
(define-const var1957 var1176 (expirerThread/-834817842 var1761)) ; Statement: $r8 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.Thread expirerThread> 
(assert true)
(define-const var875 String (append/-1031950772 var631 (cast-from-var1176-to-var285 var1957))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var631!1 String)
(assert (str.prefixof var631 var631!1))
(assert true)
(define-const var3426 String (append/-1166366385 var875 125)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var875!1 String)
(assert (str.prefixof var875 var875!1))
(assert true)
(define-const var3621 String (toString/-2075883882 var3426)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), timeToLiveMillis/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), expirationIntervalMillis/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], long), running/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), expirerThread/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], java.lang.Thread), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1176-to-var285=([java.lang.Thread], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2986=org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread, var1761=r1, var1679=$r0, var3604=$r2, var3804=$l0, var3244=$r3, var3360=$r4, var2481=$l1, var1686=$r5, var407=$r6, var3557=$z0, var781=$r7, var631=$r9, var1176=java.lang.Thread, var1957=$r8, var285=java.lang.Object, var875=$r10, var3426=$r11, var3621=$r12}
; {org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread=var2986, r1=var1761, $r0=var1679, $r2=var3604, $l0=var3804, $r3=var3244, $r4=var3360, $l1=var2481, $r5=var1686, $r6=var407, $z0=var3557, $r7=var781, $r9=var631, java.lang.Thread=var1176, $r8=var1957, java.lang.Object=var285, $r10=var875, $r11=var3426, $r12=var3621}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpireThread{, timeToLiveMillis=");	$l0 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: long timeToLiveMillis>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", expirationIntervalMillis=");	$l1 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: long expirationIntervalMillis>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", running=");	$z0 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: boolean running>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", expirerThread=");	$r8 = r1.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.Thread expirerThread>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1