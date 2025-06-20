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

(declare-sort var3903 0)
(declare-sort var1176 0)
(declare-sort var3672 0)
(declare-sort var2557 0)
(declare-sort var2613 0)
(declare-sort var3490 0)
(declare-sort var1650 0)
(declare-sort var286 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2557) void)
(declare-fun cast-from-var3903-to-var2557 (var3903) var2557)
(declare-fun enabled/-1063266783 (var3903) Bool)
(declare-fun healthy/-1063266783 (var3903) Bool)
(declare-fun var2613-init () var2613)
(declare-fun <init>/-201242697 (var2613) void)
(declare-fun cast-from-var2613-to-var3490 (var2613) var3490)
(declare-fun metadata/-1063266783 (var3903) var3490)
(declare-fun var1650-init () var1650)
(declare-fun <init>/-2175807 (var1650) void)
(declare-fun cast-from-var1650-to-var3490 (var1650) var3490)
(declare-fun instanceAddressURL/-1063266783 (var3903) var3490)
(declare-fun var286-init () var286)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2557) String)
(declare-fun cast-from-Int-to-var2557 (Int) var2557)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var286 String) void)
(declare-const null-var3903 var3903)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var3672 var3672)
(declare-const var3329 var3903) ; Statement: r0 := @this: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var3329 null-var3903)))
(declare-const var8 String) ; Statement: r9 := @parameter0: java.lang.String 
(assert (not (= var8 null-String)))
(declare-const var2451 String) ; Statement: r10 := @parameter1: java.lang.String 
(assert (not (= var2451 null-String)))
(declare-const var3268 Int) ; Statement: r3 := @parameter2: java.lang.Integer 
(assert (not (= var3268 null-Int)))
(declare-const var3750 var3672) ; Statement: r11 := @parameter3: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var3750 null-var3672)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3903-to-var2557 var3329))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3329!1 var3903)
(declare-const var3329!2 var3903)
(assert (not (= var3329!2 null-var3903)))
(assert (= (enabled/-1063266783 var3329!2) (ite (= 1 1) true false))) ; Statement: r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean enabled> = 1 
(declare-const var3329!3 var3903)
(assert (not (= var3329!3 null-var3903)))
(assert (= (healthy/-1063266783 var3329!3) (ite (= 1 1) true false))) ; Statement: r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean healthy> = 1 
(define-const var336 var2613 var2613-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var336)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>()>() 

(declare-const var336!1 var2613)
(declare-const var3329!4 var3903)
(assert (not (= var3329!4 null-var3903)))
(assert (= (metadata/-1063266783 var3329!4) (cast-from-var2613-to-var3490 var336!1))) ; Statement: r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.util.Map metadata> = $r1 
(define-const var2257 var1650 var1650-init) ; Statement: $r2 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2257)) ; Statement: specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2257!1 var1650)
(declare-const var3329!5 var3903)
(assert (not (= var3329!5 null-var3903)))
(assert (= (instanceAddressURL/-1063266783 var3329!5) (cast-from-var1650-to-var3490 var2257!1))) ; Statement: r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.util.Map instanceAddressURL> = $r2 
 ; Statement: if r3 == null goto $r4 = new java.lang.IllegalArgumentException 
(assert (= var3268 null-Int)) ; Cond: r3 == null 
(define-const var2768 var286 var286-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(define-const var1585 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1585)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1585!1 String)
(assert (= var1585!1 ""))
(assert true)
(define-const var3584 String (append/672562846 var1585!1 "The port value is illegal, the value is ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The port value is illegal, the value is ") 
(declare-const var1585!2 String)
(assert (= var1585!2 (str.++ var1585!1 "The port value is illegal, the value is ")))
(assert true)
(define-const var3319 String (append/-1031950772 var3584 (cast-from-Int-to-var2557 var3268))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var3584!1 String)
(assert (str.prefixof var3584 var3584!1))
(assert true)
(define-const var137 String (toString/-2075883882 var3319)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2768 var137)) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8) 

(declare-const var2768!1 var286)
(declare-const var137!1 String)
 ; Statement: throw $r4 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3903-to-var2557=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.lang.Object), enabled/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], boolean), healthy/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], boolean), var2613-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var2613-to-var3490=([java.util.HashMap], java.util.Map), metadata/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.util.Map), var1650-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1650-to-var3490=([java.util.concurrent.ConcurrentHashMap], java.util.Map), instanceAddressURL/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.util.Map), var286-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var2557=([java.lang.Integer], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3903=org.apache.dubbo.registry.client.DefaultServiceInstance, var3329=r0, var8=r9, var1176=null_type, var2451=r10, var3268=r3, var3672=org.apache.dubbo.rpc.model.ApplicationModel, var3750=r11, var2557=java.lang.Object, var2613=java.util.HashMap, var336=$r1, var3490=java.util.Map, var1650=java.util.concurrent.ConcurrentHashMap, var2257=$r2, var286=java.lang.IllegalArgumentException, var2768=$r4, var1585=$r5, var3584=$r6, var3319=$r7, var137=$r8}
; {org.apache.dubbo.registry.client.DefaultServiceInstance=var3903, r0=var3329, r9=var8, null_type=var1176, r10=var2451, r3=var3268, org.apache.dubbo.rpc.model.ApplicationModel=var3672, r11=var3750, java.lang.Object=var2557, java.util.HashMap=var2613, $r1=var336, java.util.Map=var3490, java.util.concurrent.ConcurrentHashMap=var1650, $r2=var2257, java.lang.IllegalArgumentException=var286, $r4=var2768, $r5=var1585, $r6=var3584, $r7=var3319, $r8=var137}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.DefaultServiceInstance;	r9 := @parameter0: java.lang.String;	r10 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.Integer;	r11 := @parameter3: org.apache.dubbo.rpc.model.ApplicationModel;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean enabled> = 1;	r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean healthy> = 1;	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.util.Map metadata> = $r1;	$r2 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.util.Map instanceAddressURL> = $r2;	if r3 == null goto $r4 = new java.lang.IllegalArgumentException;	$r4 = new java.lang.IllegalArgumentException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The port value is illegal, the value is ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8);	throw $r4
;block_num 2