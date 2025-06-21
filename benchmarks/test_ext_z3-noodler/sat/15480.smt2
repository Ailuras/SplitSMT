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

(declare-sort var2463 0)
(declare-sort var3777 0)
(declare-sort var1042 0)
(declare-sort var3271 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var3777) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toFullString/-798704221 (var3777) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun multicast/132386392 (var2463 String) void)
(declare-const null-var2463 var2463)
(declare-const null-var3777 var3777)
(declare-const null-var1042 var1042)
(declare-const null-var3271 var3271)
(declare-const var3882 var2463) ; Statement: r3 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry 
(assert (not (= var3882 null-var2463)))
(declare-const var362 var3777) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var362 null-var3777)))
(declare-const var3898 var1042) ; Statement: r9 := @parameter1: org.apache.dubbo.registry.NotifyListener 
(assert (not (= var3898 null-var1042)))
(define-const var2656 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var462 String (getServiceInterface/-1311863806 var362)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var1138 Bool (= var2656 var462)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = new java.lang.StringBuilder 
(assert (= (ite var1138 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3304 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3304)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3304!1 String)
(assert (= var3304!1 ""))
(assert true)
(define-const var2692 String (append/672562846 var3304!1 "subscribe ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("subscribe ") 
(declare-const var3304!2 String)
(assert (= var3304!2 (str.++ var3304!1 "subscribe ")))
(assert true)
(define-const var2832 String (toFullString/-798704221 var362)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var1111 String (append/672562846 var2692 var2832)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2692!1 String)
(assert (= var2692!1 (str.++ var2692 var2832)))
(assert true)
(define-const var3436 String (toString/-2075883882 var1111)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (multicast/132386392 var3882 var3436)) ; Statement: specialinvoke r3.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r8) 

(declare-const var3882!1 var2463)
(declare-const var3436!1 String)
 ; Statement: entermonitor r9 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1643 var3271) ; Statement: $r10 := @caughtexception 
(assert (not (= var1643 null-var3271)))
(assert true) ; Non Conditional
 ; Statement: exitmonitor r9 
(assert true) ; Non Conditional
 ; Statement: throw $r10 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), multicast/132386392=([org.apache.dubbo.registry.multicast.MulticastRegistry, java.lang.String], void)}
; {var2463=org.apache.dubbo.registry.multicast.MulticastRegistry, var3882=r3, var3777=org.apache.dubbo.common.URL, var362=r0, var1042=org.apache.dubbo.registry.NotifyListener, var3898=r9, var2656=$r2, var462=$r1, var1138=$z0, var3304=$r4, var2692=$r6, var2832=$r5, var1111=$r7, var3436=$r8, var3271=java.lang.Throwable, var1643=$r10}
; {org.apache.dubbo.registry.multicast.MulticastRegistry=var2463, r3=var3882, org.apache.dubbo.common.URL=var3777, r0=var362, org.apache.dubbo.registry.NotifyListener=var1042, r9=var3898, $r2=var2656, $r1=var462, $z0=var1138, $r4=var3304, $r6=var2692, $r5=var2832, $r7=var1111, $r8=var3436, java.lang.Throwable=var3271, $r10=var1643}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r9 := @parameter1: org.apache.dubbo.registry.NotifyListener;	$r2 = "*";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r4 = new java.lang.StringBuilder;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("subscribe ");	$r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r3.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r8);	entermonitor r9;	$r10 := @caughtexception;	exitmonitor r9;	throw $r10
;block_num 5