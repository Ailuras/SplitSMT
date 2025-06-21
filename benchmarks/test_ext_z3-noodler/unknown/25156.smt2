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

(declare-sort var3444 0)
(declare-sort var3324 0)
(declare-sort var3086 0)
(declare-sort var27 0)
(declare-sort var666 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/1236144978 (var3444) var3324)
(declare-fun getParameter/2144001655 (var3324 String Bool) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun append/-1031950772 (String var666) String)
(declare-fun cast-from-var3086-to-var666 (var3086) var666)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getHost/-1506772130 (var3324) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getPort/20614931 (var3324) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3444 var3444)
(declare-const var27-HTTP_SCHEME var3086)
(declare-const var931 var3444) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var931 null-var3444)))
(define-const var3575 var3324 (url/1236144978 var931)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var1297 Bool (getParameter/2144001655 var3575 "ssl-enabled" (ite (= 1 0) true false))) ; Statement: z0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("ssl-enabled", 0) 
 ; Statement: if z0 == 0 goto $r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTP_SCHEME> 
(assert (= (ite var1297 1 0) 0)) ; Cond: z0 == 0 
(define-const var405 var3086 var27-HTTP_SCHEME) ; Statement: $r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTP_SCHEME> 
(assert true) ; Non Conditional
(define-const var704 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var704)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var704!1 String)
(assert (= var704!1 ""))
(assert true)
(define-const var736 String (append/-1031950772 var704!1 (cast-from-var3086-to-var666 var405))) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13) 
(declare-const var704!2 String)
(assert (str.prefixof var704!1 var704!2))
(assert true)
(define-const var3825 String (append/672562846 var736 "://")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("://") 
(declare-const var736!1 String)
(assert (= var736!1 (str.++ var736 "://")))
(define-const var3930 var3324 (url/1236144978 var931)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2101 String (getHost/-1506772130 var3930)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var2663 String (append/672562846 var3825 var2101)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3825!1 String)
(assert (= var3825!1 (str.++ var3825 var2101)))
(assert true)
(define-const var2471 String (append/-1166366385 var2663 58)) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2663!1 String)
(assert (str.prefixof var2663 var2663!1))
(define-const var1903 var3324 (url/1236144978 var931)) ; Statement: $r8 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var3791 Int (getPort/20614931 var1903)) ; Statement: $i0 = virtualinvoke $r8.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var742 String (append/-1001720160 var2471 var3791)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var2471!1 String)
(assert (str.prefixof var2471 var2471!1))
(assert true)
(define-const var1138 String (append/-1166366385 var742 47)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var742!1 String)
(assert (str.prefixof var742 var742!1))
(assert true)
(define-const var1670 String (toString/-2075883882 var1138)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {url/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], org.apache.dubbo.common.URL), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3086-to-var666=([io.netty.util.AsciiString], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3444=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var931=r0, var3324=org.apache.dubbo.common.URL, var3575=$r1, var1297=z0, var3086=io.netty.util.AsciiString, var27=org.apache.dubbo.rpc.protocol.tri.TripleConstants, var405=$r13, var704=$r2, var666=java.lang.Object, var736=$r3, var3825=$r6, var3930=$r4, var2101=$r5, var2663=$r7, var2471=$r9, var1903=$r8, var3791=$i0, var742=$r10, var1138=$r11, var1670=$r12}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var3444, r0=var931, org.apache.dubbo.common.URL=var3324, $r1=var3575, z0=var1297, io.netty.util.AsciiString=var3086, org.apache.dubbo.rpc.protocol.tri.TripleConstants=var27, $r13=var405, $r2=var704, java.lang.Object=var666, $r3=var736, $r6=var3825, $r4=var3930, $r5=var2101, $r7=var2663, $r9=var2471, $r8=var1903, $i0=var3791, $r10=var742, $r11=var1138, $r12=var1670}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url>;	z0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("ssl-enabled", 0);	if z0 == 0 goto $r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTP_SCHEME>;	$r13 = <org.apache.dubbo.rpc.protocol.tri.TripleConstants: io.netty.util.AsciiString HTTP_SCHEME>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("://");	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r8 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.URL url>;	$i0 = virtualinvoke $r8.<org.apache.dubbo.common.URL: int getPort()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 3