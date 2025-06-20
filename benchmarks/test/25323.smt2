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

(declare-sort var653 0)
(declare-sort var2165 0)
(declare-sort var1689 0)
(declare-sort var1619 0)
(declare-sort var3162 0)
(declare-sort var2446 0)
(declare-sort var3724 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1689_isEnabled/-891662930 (var2165) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getPort/20614931 (var2165) Int)
(declare-fun getParameter/448702405 (var2165 String Int) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun responseObserver/1076168101 (var653) var1619)
(declare-fun var2446_bootstrap$/709378855 (String) var3162)
(declare-fun addHeadersCustomizer/28970706 (var3724 var3162) void)
(declare-fun cast-from-var1619-to-var3724 (var1619) var3724)
(declare-const null-var653 var653)
(declare-const null-var2165 var2165)
(declare-const var3840 var653) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener 
(assert (not (= var3840 null-var653)))
(declare-const var915 var2165) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var915 null-var2165)))
(define-const var2029 Bool (var1689_isEnabled/-891662930 var915)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.Http3Exchanger: boolean isEnabled(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: if $z0 == 0 goto $r10 = "h2" 
(assert (not (= (ite var2029 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var46 String "h3") ; Statement: $r10 = "h3" 
 ; Statement: goto [?= $r1 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var3820 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3820)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3820!1 String)
(assert (= var3820!1 ""))
(assert true)
(define-const var645 String (append/672562846 var3820!1 var46)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3820!2 String)
(assert (= var3820!2 (str.++ var3820!1 var46)))
(assert true)
(define-const var3225 String (append/672562846 var645 "=\u0022:")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=\":") 
(declare-const var645!1 String)
(assert (= var645!1 (str.++ var645 "=\u0022:")))
(assert true)
(define-const var3097 Int (getPort/20614931 var915)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var2558 Int (getParameter/448702405 var915 "bind.port" var3097)) ; Statement: $i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0) 
(assert true)
(define-const var1977 String (append/-1001720160 var3225 var2558)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var3225!1 String)
(assert (str.prefixof var3225 var3225!1))
(assert true)
(define-const var310 String (append/-1166366385 var1977 34)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(34) 
(declare-const var1977!1 String)
(assert (str.prefixof var1977 var1977!1))
(assert true)
(define-const var375 String (toString/-2075883882 var310)) ; Statement: $r9 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2834 var1619 (responseObserver/1076168101 var3840)) ; Statement: $r7 = r6.<org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener: org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver responseObserver> 
(define-const var2615 var3162 (var2446_bootstrap$/709378855 var375)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401: java.util.function.BiConsumer bootstrap$(java.lang.String)>($r9) 
(assert true)
;(assert (addHeadersCustomizer/28970706 (cast-from-var1619-to-var3724 var2834) var2615)) ; Statement: virtualinvoke $r7.<org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver: void addHeadersCustomizer(java.util.function.BiConsumer)>($r8) 

(declare-const var2834!1 var1619)
(declare-const var2615!1 var3162)
 ; Statement: return 
(check-sat)
; {var1689_isEnabled/-891662930=([org.apache.dubbo.common.URL], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), responseObserver/1076168101=([org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener], org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver), var2446_bootstrap$/709378855=([java.lang.String], java.util.function.BiConsumer), addHeadersCustomizer/28970706=([org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver, java.util.function.BiConsumer], void), cast-from-var1619-to-var3724=([org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver], org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver)}
; {var653=org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener, var3840=r6, var2165=org.apache.dubbo.common.URL, var915=r0, var1689=org.apache.dubbo.rpc.protocol.tri.Http3Exchanger, var2029=$z0, var46=$r10, var3820=$r1, var645=$r2, var3225=$r3, var3097=$i0, var2558=$i1, var1977=$r4, var310=$r5, var375=$r9, var1619=org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver, var2834=$r7, var3162=java.util.function.BiConsumer, var2446=org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401, var2615=$r8, var3724=org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver}
; {org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener=var653, r6=var3840, org.apache.dubbo.common.URL=var2165, r0=var915, org.apache.dubbo.rpc.protocol.tri.Http3Exchanger=var1689, $z0=var2029, $r10=var46, $r1=var3820, $r2=var645, $r3=var3225, $i0=var3097, $i1=var2558, $r4=var1977, $r5=var310, $r9=var375, org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver=var1619, $r7=var2834, java.util.function.BiConsumer=var3162, org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401=var2446, $r8=var2615, org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver=var3724}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener;	r0 := @parameter0: org.apache.dubbo.common.URL;	$z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.Http3Exchanger: boolean isEnabled(org.apache.dubbo.common.URL)>(r0);	if $z0 == 0 goto $r10 = "h2";	$r10 = "h3";	goto [?= $r1 = new java.lang.StringBuilder];	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=\":");	$i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>();	$i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(34);	$r9 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = r6.<org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener: org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver responseObserver>;	$r8 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.h12.http1.DefaultHttp11ServerTransportListener$lambda_initializeAltSvc_1__1401: java.util.function.BiConsumer bootstrap$(java.lang.String)>($r9);	virtualinvoke $r7.<org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver: void addHeadersCustomizer(java.util.function.BiConsumer)>($r8);	return
;block_num 3