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

(declare-sort var2349 0)
(declare-sort var632 0)
(declare-sort var1363 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun channel/-2043084809 (var2349) var632)
(declare-fun append/-1031950772 (String var1363) String)
(declare-fun cast-from-var632-to-var1363 (var632) var1363)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2349 var2349)
(declare-const var1991 var2349) ; Statement: r1 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient 
(assert (not (= var1991 null-var2349)))
(define-const var3571 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3571)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3571!1 String)
(assert (= var3571!1 ""))
(assert true)
(define-const var2590 String (append/672562846 var3571!1 "HeaderExchangeClient [channel=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HeaderExchangeClient [channel=") 
(declare-const var3571!2 String)
(assert (= var3571!2 (str.++ var3571!1 "HeaderExchangeClient [channel=")))
(define-const var3762 var632 (channel/-2043084809 var1991)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient: org.apache.dubbo.remoting.exchange.ExchangeChannel channel> 
(assert true)
(define-const var1730 String (append/-1031950772 var2590 (cast-from-var632-to-var1363 var3762))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2590!1 String)
(assert (str.prefixof var2590 var2590!1))
(assert true)
(define-const var2254 String (append/672562846 var1730 "]")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var1730!1 String)
(assert (= var1730!1 (str.++ var1730 "]")))
(assert true)
(define-const var1059 String (toString/-2075883882 var2254)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), channel/-2043084809=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient], org.apache.dubbo.remoting.exchange.ExchangeChannel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var632-to-var1363=([org.apache.dubbo.remoting.exchange.ExchangeChannel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2349=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient, var1991=r1, var3571=$r0, var2590=$r3, var632=org.apache.dubbo.remoting.exchange.ExchangeChannel, var3762=$r2, var1363=java.lang.Object, var1730=$r4, var2254=$r5, var1059=$r6}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient=var2349, r1=var1991, $r0=var3571, $r3=var2590, org.apache.dubbo.remoting.exchange.ExchangeChannel=var632, $r2=var3762, java.lang.Object=var1363, $r4=var1730, $r5=var2254, $r6=var1059}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HeaderExchangeClient [channel=");	$r2 = r1.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient: org.apache.dubbo.remoting.exchange.ExchangeChannel channel>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1