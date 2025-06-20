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

(declare-sort var2240 0)
(declare-sort var1378 0)
(declare-sort var3278 0)
(declare-sort var1317 0)
(declare-sort var2063 0)
(declare-sort var2018 0)
(declare-sort var592 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3278_isEnabled/-891662930 (var1378) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getPort/20614931 (var1378) Int)
(declare-fun getParameter/448702405 (var1378 String Int) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun responseObserver/1076168101 (var2240) var1317)
(declare-fun var2018_bootstrap$/709378855 (String) var2063)
(declare-fun addHeadersCustomizer/28970706 (var592 var2063) void)
(declare-fun cast-from-var1317-to-var592 (var1317) var592)
(declare-const null-var2240 var2240)
(declare-const null-var1378 var1378)
(declare-const var1887 var2240) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener 
(assert (not (= var1887 null-var2240)))
(declare-const var906 var1378) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var906 null-var1378)))
(define-const var3784 Bool (var3278_isEnabled/-891662930 var906)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.Http3Exchanger: boolean isEnabled(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: if $z0 == 0 goto $r10 = "h2" 
(assert (= (ite var3784 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3642 String "h2") ; Statement: $r10 = "h2" 
(assert true) ; Non Conditional
(define-const var678 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var678)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var678!1 String)
(assert (= var678!1 ""))
(assert true)
(define-const var3279 String (append/672562846 var678!1 var3642)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var678!2 String)
(assert (= var678!2 (str.++ var678!1 var3642)))
(assert true)
(define-const var3418 String (append/672562846 var3279 "=\u0022:")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=\":") 
(declare-const var3279!1 String)
(assert (= var3279!1 (str.++ var3279 "=\u0022:")))
(assert true)
(define-const var1352 Int (getPort/20614931 var906)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var1565 Int (getParameter/448702405 var906 "bind.port" var1352)) ; Statement: $i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0) 
(assert true)
(define-const var2709 String (append/-1001720160 var3418 var1565)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var3418!1 String)
(assert (str.prefixof var3418 var3418!1))
(assert true)
(define-const var2221 String (append/-1166366385 var2709 34)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(34) 
(declare-const var2709!1 String)
(assert (str.prefixof var2709 var2709!1))
(assert true)
(define-const var2901 String (toString/-2075883882 var2221)) ; Statement: $r9 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3645 var1317 (responseObserver/1076168101 var1887)) ; Statement: $r7 = r6.<org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener: org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver responseObserver> 
(define-const var1740 var2063 (var2018_bootstrap$/709378855 var2901)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401: java.util.function.BiConsumer bootstrap$(java.lang.String)>($r9) 
(assert true)
;(assert (addHeadersCustomizer/28970706 (cast-from-var1317-to-var592 var3645) var1740)) ; Statement: virtualinvoke $r7.<org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver: void addHeadersCustomizer(java.util.function.BiConsumer)>($r8) 

(declare-const var3645!1 var1317)
(declare-const var1740!1 var2063)
 ; Statement: return 
(check-sat)
; {var3278_isEnabled/-891662930=([org.apache.dubbo.common.URL], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), responseObserver/1076168101=([org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener], org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver), var2018_bootstrap$/709378855=([java.lang.String], java.util.function.BiConsumer), addHeadersCustomizer/28970706=([org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver, java.util.function.BiConsumer], void), cast-from-var1317-to-var592=([org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver], org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver)}
; {var2240=org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener, var1887=r6, var1378=org.apache.dubbo.common.URL, var906=r0, var3278=org.apache.dubbo.rpc.protocol.tri.Http3Exchanger, var3784=$z0, var3642=$r10, var678=$r1, var3279=$r2, var3418=$r3, var1352=$i0, var1565=$i1, var2709=$r4, var2221=$r5, var2901=$r9, var1317=org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver, var3645=$r7, var2063=java.util.function.BiConsumer, var2018=org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401, var1740=$r8, var592=org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver}
; {org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener=var2240, r6=var1887, org.apache.dubbo.common.URL=var1378, r0=var906, org.apache.dubbo.rpc.protocol.tri.Http3Exchanger=var3278, $z0=var3784, $r10=var3642, $r1=var678, $r2=var3279, $r3=var3418, $i0=var1352, $i1=var1565, $r4=var2709, $r5=var2221, $r9=var2901, org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver=var1317, $r7=var3645, java.util.function.BiConsumer=var2063, org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401=var2018, $r8=var1740, org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver=var592}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener;	r0 := @parameter0: org.apache.dubbo.common.URL;	$z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.Http3Exchanger: boolean isEnabled(org.apache.dubbo.common.URL)>(r0);	if $z0 == 0 goto $r10 = "h2";	$r10 = "h2";	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=\":");	$i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>();	$i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(34);	$r9 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = r6.<org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener: org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver responseObserver>;	$r8 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401: java.util.function.BiConsumer bootstrap$(java.lang.String)>($r9);	virtualinvoke $r7.<org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver: void addHeadersCustomizer(java.util.function.BiConsumer)>($r8);	return
;block_num 3