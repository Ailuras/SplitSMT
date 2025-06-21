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

(declare-sort var3128 0)
(declare-sort var1221 0)
(declare-sort var1865 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHost/-1506772130 (var1221) String)
(declare-fun getParameter/506106603 (var1221 String String) String)
(declare-fun getParameter/2144001655 (var1221 String Bool) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1865_getIpByHost/-2004076751 (String) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getPort/20614931 (var1221) Int)
(declare-fun getParameter/448702405 (var1221 String Int) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3128 var3128)
(declare-const null-var1221 var1221)
(declare-const var1661 var3128) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol 
(assert (not (= var1661 null-var3128)))
(declare-const var1096 var1221) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1096 null-var1221)))
(assert true)
(define-const var1016 String (getHost/-1506772130 var1096)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var2326 String (getParameter/506106603 var1096 "bind.ip" var1016)) ; Statement: r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("bind.ip", $r1) 
(assert true)
(define-const var271 Bool (getParameter/2144001655 var1096 "anyhost" (ite (= 1 0) true false))) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("anyhost", 0) 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var271 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1517 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1517)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1517!1 String)
(assert (= var1517!1 ""))
(define-const var339 String (var1865_getIpByHost/-2004076751 var2326)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getIpByHost(java.lang.String)>(r9) 
(assert true)
(define-const var99 String (append/672562846 var1517!1 var339)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1517!2 String)
(assert (= var1517!2 (str.++ var1517!1 var339)))
(assert true)
(define-const var2090 String (append/672562846 var99 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var99!1 String)
(assert (= var99!1 (str.++ var99 ":")))
(assert true)
(define-const var1725 Int (getPort/20614931 var1096)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var2636 Int (getParameter/448702405 var1096 "bind.port" var1725)) ; Statement: $i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0) 
(assert true)
(define-const var2932 String (append/-1001720160 var2090 var2636)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2090!1 String)
(assert (str.prefixof var2090 var2090!1))
(assert true)
(define-const var1208 String (toString/-2075883882 var2932)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1865_getIpByHost/-2004076751=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3128=org.apache.dubbo.rpc.protocol.AbstractProxyProtocol, var1661=r8, var1221=org.apache.dubbo.common.URL, var1096=r0, var1016=$r1, var2326=r9, var271=$z0, var1517=$r2, var1865=org.apache.dubbo.common.utils.NetUtils, var339=$r3, var99=$r4, var2090=$r5, var1725=$i0, var2636=$i1, var2932=$r6, var1208=$r7}
; {org.apache.dubbo.rpc.protocol.AbstractProxyProtocol=var3128, r8=var1661, org.apache.dubbo.common.URL=var1221, r0=var1096, $r1=var1016, r9=var2326, $z0=var271, $r2=var1517, org.apache.dubbo.common.utils.NetUtils=var1865, $r3=var339, $r4=var99, $r5=var2090, $i0=var1725, $i1=var2636, $r6=var2932, $r7=var1208}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("bind.ip", $r1);	$z0 = virtualinvoke r0.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("anyhost", 0);	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getIpByHost(java.lang.String)>(r9);	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>();	$i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 2