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

(declare-sort var801 0)
(declare-sort var195 0)
(declare-sort var1836 0)
(declare-sort var1854 0)
(declare-sort var2355 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun future/364746903 (var801) var195)
(declare-fun var1836-init () var1836)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1854) String)
(declare-fun cast-from-String-to-var1854 (String) var1854)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var1836 String) void)
(declare-fun completeExceptionally/-1031437253 (var195 var2355) Bool)
(declare-fun cast-from-var1836-to-var2355 (var1836) var2355)
(declare-const null-var801 var801)
(declare-const null-String String)
(declare-const var380 var801) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener 
(assert (not (= var380 null-var801)))
(declare-const var2378 String) ; Statement: r4 := @parameter0: java.lang.CharSequence 
(assert (not (= var2378 null-String)))
(define-const var3463 var195 (future/364746903 var380)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener: java.util.concurrent.CompletableFuture future> 
(define-const var2271 var1836 var1836-init) ; Statement: $r1 = new java.lang.RuntimeException 
(define-const var2530 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2530)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2530!1 String)
(assert (= var2530!1 ""))
(assert true)
(define-const var1672 String (append/672562846 var2530!1 "Status: ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Status: ") 
(declare-const var2530!2 String)
(assert (= var2530!2 (str.++ var2530!1 "Status: ")))
(assert true)
(define-const var1066 String (append/-1031950772 var1672 (cast-from-String-to-var1854 var2378))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r4) 
(declare-const var1672!1 String)
(assert (str.prefixof var1672 var1672!1))
(assert true)
(define-const var1603 String (toString/-2075883882 var1066)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var2271 var1603)) ; Statement: specialinvoke $r1.<java.lang.RuntimeException: void <init>(java.lang.String)>($r7) 

(declare-const var2271!1 var1836)
(declare-const var1603!1 String)
(assert true)
;(assert (completeExceptionally/-1031437253 var3463 (cast-from-var1836-to-var2355 var2271!1))) ; Statement: virtualinvoke $r3.<java.util.concurrent.CompletableFuture: boolean completeExceptionally(java.lang.Throwable)>($r1) 

(declare-const var3463!1 var195)
(declare-const var2271!2 var1836)
 ; Statement: return 
(check-sat)
; {future/364746903=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener], java.util.concurrent.CompletableFuture), var1836-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-String-to-var1854=([java.lang.CharSequence], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void), completeExceptionally/-1031437253=([java.util.concurrent.CompletableFuture, java.lang.Throwable], boolean), cast-from-var1836-to-var2355=([java.lang.RuntimeException], java.lang.Throwable)}
; {var801=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener, var380=r0, var2378=r4, var195=java.util.concurrent.CompletableFuture, var3463=$r3, var1836=java.lang.RuntimeException, var2271=$r1, var2530=$r2, var1672=$r5, var1854=java.lang.Object, var1066=$r6, var1603=$r7, var2355=java.lang.Throwable}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener=var801, r0=var380, r4=var2378, java.util.concurrent.CompletableFuture=var195, $r3=var3463, java.lang.RuntimeException=var1836, $r1=var2271, $r2=var2530, $r5=var1672, java.lang.Object=var1854, $r6=var1066, $r7=var1603, java.lang.Throwable=var2355}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener;	r4 := @parameter0: java.lang.CharSequence;	$r3 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener: java.util.concurrent.CompletableFuture future>;	$r1 = new java.lang.RuntimeException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Status: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.RuntimeException: void <init>(java.lang.String)>($r7);	virtualinvoke $r3.<java.util.concurrent.CompletableFuture: boolean completeExceptionally(java.lang.Throwable)>($r1);	return
;block_num 1