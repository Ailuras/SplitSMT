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

(declare-sort var2043 0)
(declare-sort var220 0)
(declare-sort var1139 0)
(declare-sort var3948 0)
(declare-sort var3126 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/967243351 (var2043) Bool)
(declare-fun var1139-init () var1139)
(declare-fun getLocalAddress/-1826531475 (var2043) var3948)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var220) String)
(declare-fun cast-from-var2043-to-var220 (var2043) var220)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/2011950133 (var1139 var3948 var3948 String) void)
(declare-const null-var2043 var2043)
(declare-const null-var220 var220)
(declare-const null-Bool Bool)
(declare-const null-NullType var3126)
(declare-const null-var3948 var3948)
(declare-const var1417 var2043) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel 
(assert (not (= var1417 null-var2043)))
(declare-const var2037 var220) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var2037 null-var220)))
(declare-const var363 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var363 null-Bool)))
(define-const var180 Bool (closed/967243351 var1417)) ; Statement: $z0 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: boolean closed> 
 ; Statement: if $z0 == 0 goto $z1 = r1 instanceof org.apache.dubbo.remoting.exchange.Request 
(assert (not (= (ite var180 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1413 var1139 var1139-init) ; Statement: $r5 = new org.apache.dubbo.remoting.RemotingException 
(assert true)
(define-const var214 var3948 (getLocalAddress/-1826531475 var1417)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.net.InetSocketAddress getLocalAddress()>() 
(define-const var6 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var6)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var6!1 String)
(assert (= var6!1 ""))
(assert true)
(define-const var620 String (append/672562846 var6!1 "Failed to send message ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ") 
(declare-const var6!2 String)
(assert (= var6!2 (str.++ var6!1 "Failed to send message ")))
(assert true)
(define-const var3943 String (append/-1031950772 var620 var2037)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var620!1 String)
(assert (str.prefixof var620 var620!1))
(assert true)
(define-const var596 String (append/672562846 var3943 ", cause: The channel ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The channel ") 
(declare-const var3943!1 String)
(assert (= var3943!1 (str.++ var3943 ", cause: The channel ")))
(assert true)
(define-const var70 String (append/-1031950772 var596 (cast-from-var2043-to-var220 var1417))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var596!1 String)
(assert (str.prefixof var596 var596!1))
(assert true)
(define-const var2034 String (append/672562846 var70 " is closed!")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!") 
(declare-const var70!1 String)
(assert (= var70!1 (str.++ var70 " is closed!")))
(assert true)
(define-const var2737 String (toString/-2075883882 var2034)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/2011950133 var1413 var214 null-var3948 var2737)) ; Statement: specialinvoke $r5.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r13, null, $r12) 

(declare-const var1413!1 var1139)
(declare-const var214!1 var3948)
(declare-const var3758 var3126)
(declare-const var2737!1 String)
 ; Statement: throw $r5 
(check-sat)
; {closed/967243351=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel], boolean), var1139-init=([], org.apache.dubbo.remoting.RemotingException), getLocalAddress/-1826531475=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel], java.net.InetSocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2043-to-var220=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/2011950133=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String], void)}
; {var2043=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel, var1417=r0, var220=java.lang.Object, var2037=r1, var363=z2, var180=$z0, var1139=org.apache.dubbo.remoting.RemotingException, var1413=$r5, var3948=java.net.InetSocketAddress, var214=$r13, var6=$r6, var620=$r7, var3943=$r8, var596=$r9, var70=$r10, var2034=$r11, var2737=$r12, var3758=null, var3126=null_type}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel=var2043, r0=var1417, java.lang.Object=var220, r1=var2037, z2=var363, $z0=var180, org.apache.dubbo.remoting.RemotingException=var1139, $r5=var1413, java.net.InetSocketAddress=var3948, $r13=var214, $r6=var6, $r7=var620, $r8=var3943, $r9=var596, $r10=var70, $r11=var2034, $r12=var2737, null=var3758, null_type=var3126}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel;	r1 := @parameter0: java.lang.Object;	z2 := @parameter1: boolean;	$z0 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: boolean closed>;	if $z0 == 0 goto $z1 = r1 instanceof org.apache.dubbo.remoting.exchange.Request;	$r5 = new org.apache.dubbo.remoting.RemotingException;	$r13 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.net.InetSocketAddress getLocalAddress()>();	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The channel ");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r5.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r13, null, $r12);	throw $r5
;block_num 2