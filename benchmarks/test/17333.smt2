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

(declare-sort var1084 0)
(declare-sort var2268 0)
(declare-sort var1327 0)
(declare-sort var848 0)
(declare-sort var2197 0)
(declare-sort var1721 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/-1591198865 (var1084) var1327)
(declare-fun get/2135855162 (var1327) Bool)
(declare-fun var848-init () var848)
(declare-fun getLocalAddress/-63303331 (var1084) var2197)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2268) String)
(declare-fun cast-from-var2197-to-var2268 (var2197) var2268)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/2011950133 (var848 var2197 var2197 String) void)
(declare-const null-var1084 var1084)
(declare-const null-var2268 var2268)
(declare-const null-Bool Bool)
(declare-const null-NullType var1721)
(declare-const null-var2197 var2197)
(declare-const var1740 var1084) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer 
(assert (not (= var1740 null-var1084)))
(declare-const var1259 var2268) ; Statement: r2 := @parameter0: java.lang.Object 
(assert (not (= var1259 null-var2268)))
(declare-const var224 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var224 null-Bool)))
(define-const var2519 var1327 (closed/-1591198865 var1740)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed> 
(assert true)
(define-const var1391 Bool (get/2135855162 var2519)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (not (= (ite var1391 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var200 var848 var848-init) ; Statement: $r4 = new org.apache.dubbo.remoting.RemotingException 
(assert true)
(define-const var3162 var2197 (getLocalAddress/-63303331 var1740)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>() 
(define-const var21 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var21)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var21!1 String)
(assert (= var21!1 ""))
(assert true)
(define-const var578 String (append/672562846 var21!1 "Failed to send message ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ") 
(declare-const var21!2 String)
(assert (= var21!2 (str.++ var21!1 "Failed to send message ")))
(assert true)
(define-const var2204 String (append/-1031950772 var578 var1259)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var578!1 String)
(assert (str.prefixof var578 var578!1))
(assert true)
(define-const var1687 String (append/672562846 var2204 ", cause: The server ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The server ") 
(declare-const var2204!1 String)
(assert (= var2204!1 (str.++ var2204 ", cause: The server ")))
(assert true)
(define-const var3765 var2197 (getLocalAddress/-63303331 var1740)) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var713 String (append/-1031950772 var1687 (cast-from-var2197-to-var2268 var3765))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var1687!1 String)
(assert (str.prefixof var1687 var1687!1))
(assert true)
(define-const var3928 String (append/672562846 var713 " is closed!")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!") 
(declare-const var713!1 String)
(assert (= var713!1 (str.++ var713 " is closed!")))
(assert true)
(define-const var3336 String (toString/-2075883882 var3928)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/2011950133 var200 var3162 null-var2197 var3336)) ; Statement: specialinvoke $r4.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r13, null, $r12) 

(declare-const var200!1 var848)
(declare-const var3162!1 var2197)
(declare-const var3250 var1721)
(declare-const var3336!1 String)
 ; Statement: throw $r4 
(check-sat)
; {closed/-1591198865=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), var848-init=([], org.apache.dubbo.remoting.RemotingException), getLocalAddress/-63303331=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], java.net.InetSocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2197-to-var2268=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/2011950133=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String], void)}
; {var1084=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer, var1740=r0, var2268=java.lang.Object, var1259=r2, var224=z1, var1327=java.util.concurrent.atomic.AtomicBoolean, var2519=$r1, var1391=$z0, var848=org.apache.dubbo.remoting.RemotingException, var200=$r4, var2197=java.net.InetSocketAddress, var3162=$r13, var21=$r5, var578=$r6, var2204=$r7, var1687=$r9, var3765=$r8, var713=$r10, var3928=$r11, var3336=$r12, var3250=null, var1721=null_type}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer=var1084, r0=var1740, java.lang.Object=var2268, r2=var1259, z1=var224, java.util.concurrent.atomic.AtomicBoolean=var1327, $r1=var2519, $z0=var1391, org.apache.dubbo.remoting.RemotingException=var848, $r4=var200, java.net.InetSocketAddress=var2197, $r13=var3162, $r5=var21, $r6=var578, $r7=var2204, $r9=var1687, $r8=var3765, $r10=var713, $r11=var3928, $r12=var3336, null=var3250, null_type=var1721}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer;	r2 := @parameter0: java.lang.Object;	z1 := @parameter1: boolean;	$r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server>;	$r4 = new org.apache.dubbo.remoting.RemotingException;	$r13 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>();	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The server ");	$r8 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r13, null, $r12);	throw $r4
;block_num 2