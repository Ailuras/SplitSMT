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

(declare-sort var3289 0)
(declare-sort var3259 0)
(declare-sort var3504 0)
(declare-sort var1054 0)
(declare-sort var3709 0)
(declare-sort var2873 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun repliers/-1046488055 (var3289) var3259)
(declare-fun var3259_entrySet/1101202697 (var3259) var3504)
(declare-fun var3504_iterator/1911472585 (var3504) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun defaultReplier/-1046488055 (var3289) var1054)
(declare-fun var3709-init () var3709)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2873) String)
(declare-fun cast-from-ClassObject-to-var2873 (ClassObject) var2873)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3709 String) void)
(declare-const null-var3289 var3289)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1054 var1054)
(declare-const var1478 var3289) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.ReplierDispatcher 
(assert (not (= var1478 null-var3289)))
(declare-const var3538 ClassObject) ; Statement: r7 := @parameter0: java.lang.Class 
(assert (not (= var3538 null-ClassObject)))
(define-const var876 var3259 (repliers/-1046488055 var1478)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.exchange.support.ReplierDispatcher: java.util.Map repliers> 
(define-const var2088 var3504 (var3259_entrySet/1101202697 var876)) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Map: java.util.Set entrySet()>() 
(define-const var3054 Iterator (var3504_iterator/1911472585 var2088)) ; Statement: r3 = interfaceinvoke $r2.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2251 Bool (Iterator_hasNext/-1669924200 var3054)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.remoting.exchange.support.ReplierDispatcher: org.apache.dubbo.remoting.exchange.support.Replier defaultReplier> 
(assert (= (ite var2251 1 0) 0)) ; Cond: $z0 == 0 
(define-const var309 var1054 (defaultReplier/-1046488055 var1478)) ; Statement: $r4 = r0.<org.apache.dubbo.remoting.exchange.support.ReplierDispatcher: org.apache.dubbo.remoting.exchange.support.Replier defaultReplier> 
 ; Statement: if $r4 == null goto $r5 = new java.lang.IllegalStateException 
(assert (= var309 null-var1054)) ; Cond: $r4 == null 
(define-const var3583 var3709 var3709-init) ; Statement: $r5 = new java.lang.IllegalStateException 
(define-const var3268 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3268)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3268!1 String)
(assert (= var3268!1 ""))
(assert true)
(define-const var2393 String (append/672562846 var3268!1 "Replier not found, Unsupported message object: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Replier not found, Unsupported message object: ") 
(declare-const var3268!2 String)
(assert (= var3268!2 (str.++ var3268!1 "Replier not found, Unsupported message object: ")))
(assert true)
(define-const var1108 String (append/-1031950772 var2393 (cast-from-ClassObject-to-var2873 var3538))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r7) 
(declare-const var2393!1 String)
(assert (str.prefixof var2393 var2393!1))
(assert true)
(define-const var192 String (toString/-2075883882 var1108)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3583 var192)) ; Statement: specialinvoke $r5.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10) 

(declare-const var3583!1 var3709)
(declare-const var192!1 String)
 ; Statement: throw $r5 
(check-sat)
; {repliers/-1046488055=([org.apache.dubbo.remoting.exchange.support.ReplierDispatcher], java.util.Map), var3259_entrySet/1101202697=([java.util.Map], java.util.Set), var3504_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), defaultReplier/-1046488055=([org.apache.dubbo.remoting.exchange.support.ReplierDispatcher], org.apache.dubbo.remoting.exchange.support.Replier), var3709-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2873=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3289=org.apache.dubbo.remoting.exchange.support.ReplierDispatcher, var1478=r0, var3538=r7, var3259=java.util.Map, var876=$r1, var3504=java.util.Set, var2088=$r2, var3054=r3, var2251=$z0, var1054=org.apache.dubbo.remoting.exchange.support.Replier, var309=$r4, var3709=java.lang.IllegalStateException, var3583=$r5, var3268=$r6, var2393=$r8, var2873=java.lang.Object, var1108=$r9, var192=$r10}
; {org.apache.dubbo.remoting.exchange.support.ReplierDispatcher=var3289, r0=var1478, r7=var3538, java.util.Map=var3259, $r1=var876, java.util.Set=var3504, $r2=var2088, r3=var3054, $z0=var2251, org.apache.dubbo.remoting.exchange.support.Replier=var1054, $r4=var309, java.lang.IllegalStateException=var3709, $r5=var3583, $r6=var3268, $r8=var2393, java.lang.Object=var2873, $r9=var1108, $r10=var192}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.ReplierDispatcher;	r7 := @parameter0: java.lang.Class;	$r1 = r0.<org.apache.dubbo.remoting.exchange.support.ReplierDispatcher: java.util.Map repliers>;	$r2 = interfaceinvoke $r1.<java.util.Map: java.util.Set entrySet()>();	r3 = interfaceinvoke $r2.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.remoting.exchange.support.ReplierDispatcher: org.apache.dubbo.remoting.exchange.support.Replier defaultReplier>;	$r4 = r0.<org.apache.dubbo.remoting.exchange.support.ReplierDispatcher: org.apache.dubbo.remoting.exchange.support.Replier defaultReplier>;	if $r4 == null goto $r5 = new java.lang.IllegalStateException;	$r5 = new java.lang.IllegalStateException;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Replier not found, Unsupported message object: ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r5.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10);	throw $r5
;block_num 4