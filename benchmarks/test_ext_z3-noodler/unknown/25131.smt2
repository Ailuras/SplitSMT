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

(declare-sort var2002 0)
(declare-sort var70 0)
(declare-sort var3342 0)
(declare-sort var2190 0)
(declare-sort var1481 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/1236144978 (var2002) var70)
(declare-fun getParameter/2144001655 (var70 String Bool) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun append/-1031950772 (String var1481) String)
(declare-fun cast-from-var3342-to-var1481 (var3342) var1481)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getHost/-1506772130 (var70) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getPort/20614931 (var70) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2002 var2002)
(declare-const var2190-HTTPS_SCHEME var3342)
(declare-const var1624 var2002) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var1624 null-var2002)))
(define-const var2950 var70 (url/1236144978 var1624)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var788 Bool (getParameter/2144001655 var2950 "ssl-enabled" (ite (= 1 0) true false))) ; Statement: z0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("ssl-enabled", 0) 
 ; Statement: if z0 == 0 goto $r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTP_SCHEME> 
(assert (not (= (ite var788 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var613 var3342 var2190-HTTPS_SCHEME) ; Statement: $r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTPS_SCHEME> 
 ; Statement: goto [?= $r2 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var1896 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1896)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1896!1 String)
(assert (= var1896!1 ""))
(assert true)
(define-const var1080 String (append/-1031950772 var1896!1 (cast-from-var3342-to-var1481 var613))) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13) 
(declare-const var1896!2 String)
(assert (str.prefixof var1896!1 var1896!2))
(assert true)
(define-const var2712 String (append/672562846 var1080 "://")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("://") 
(declare-const var1080!1 String)
(assert (= var1080!1 (str.++ var1080 "://")))
(define-const var434 var70 (url/1236144978 var1624)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var461 String (getHost/-1506772130 var434)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var3419 String (append/672562846 var2712 var461)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2712!1 String)
(assert (= var2712!1 (str.++ var2712 var461)))
(assert true)
(define-const var887 String (append/-1166366385 var3419 58)) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var3419!1 String)
(assert (str.prefixof var3419 var3419!1))
(define-const var2738 var70 (url/1236144978 var1624)) ; Statement: $r8 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var3053 Int (getPort/20614931 var2738)) ; Statement: $i0 = virtualinvoke $r8.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var125 String (append/-1001720160 var887 var3053)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var887!1 String)
(assert (str.prefixof var887 var887!1))
(assert true)
(define-const var3326 String (append/-1166366385 var125 47)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var125!1 String)
(assert (str.prefixof var125 var125!1))
(assert true)
(define-const var2211 String (toString/-2075883882 var3326)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {url/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], org.apache.dubbo.common.URL), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3342-to-var1481=([io.netty.util.AsciiString], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2002=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var1624=r0, var70=org.apache.dubbo.common.URL, var2950=$r1, var788=z0, var3342=io.netty.util.AsciiString, var2190=org.apache.dubbo.rpc.protocol.tri.TripleConstants, var613=$r13, var1896=$r2, var1481=java.lang.Object, var1080=$r3, var2712=$r6, var434=$r4, var461=$r5, var3419=$r7, var887=$r9, var2738=$r8, var3053=$i0, var125=$r10, var3326=$r11, var2211=$r12}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var2002, r0=var1624, org.apache.dubbo.common.URL=var70, $r1=var2950, z0=var788, io.netty.util.AsciiString=var3342, org.apache.dubbo.rpc.protocol.tri.TripleConstants=var2190, $r13=var613, $r2=var1896, java.lang.Object=var1481, $r3=var1080, $r6=var2712, $r4=var434, $r5=var461, $r7=var3419, $r9=var887, $r8=var2738, $i0=var3053, $r10=var125, $r11=var3326, $r12=var2211}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url>;	z0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("ssl-enabled", 0);	if z0 == 0 goto $r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTP_SCHEME>;	$r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTPS_SCHEME>;	goto [?= $r2 = new java.lang.StringBuilder];	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("://");	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r8 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url>;	$i0 = virtualinvoke $r8.<org.apache.dubbo.common.URL: int getPort()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 3