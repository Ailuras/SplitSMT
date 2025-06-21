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

(declare-sort var3248 0)
(declare-sort var2097 0)
(declare-sort var3821 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHost/-1506772130 (var2097) String)
(declare-fun getParameter/506106603 (var2097 String String) String)
(declare-fun getParameter/2144001655 (var2097 String Bool) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3821_getIpByHost/-2004076751 (String) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getPort/20614931 (var2097) Int)
(declare-fun getParameter/448702405 (var2097 String Int) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3248 var3248)
(declare-const null-var2097 var2097)
(declare-const var3865 var3248) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.AbstractProtocol 
(assert (not (= var3865 null-var3248)))
(declare-const var707 var2097) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var707 null-var2097)))
(assert true)
(define-const var3164 String (getHost/-1506772130 var707)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var1575 String (getParameter/506106603 var707 "bind.ip" var3164)) ; Statement: r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("bind.ip", $r1) 
(assert true)
(define-const var3773 Bool (getParameter/2144001655 var707 "anyhost" (ite (= 1 0) true false))) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("anyhost", 0) 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var3773 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2697 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2697)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2697!1 String)
(assert (= var2697!1 ""))
(define-const var3781 String (var3821_getIpByHost/-2004076751 var1575)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getIpByHost(java.lang.String)>(r9) 
(assert true)
(define-const var2412 String (append/672562846 var2697!1 var3781)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2697!2 String)
(assert (= var2697!2 (str.++ var2697!1 var3781)))
(assert true)
(define-const var1143 String (append/672562846 var2412 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var2412!1 String)
(assert (= var2412!1 (str.++ var2412 ":")))
(assert true)
(define-const var3157 Int (getPort/20614931 var707)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var3840 Int (getParameter/448702405 var707 "bind.port" var3157)) ; Statement: $i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0) 
(assert true)
(define-const var2095 String (append/-1001720160 var1143 var3840)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var1143!1 String)
(assert (str.prefixof var1143 var1143!1))
(assert true)
(define-const var3901 String (toString/-2075883882 var2095)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3821_getIpByHost/-2004076751=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3248=org.apache.dubbo.rpc.protocol.AbstractProtocol, var3865=r8, var2097=org.apache.dubbo.common.URL, var707=r0, var3164=$r1, var1575=r9, var3773=$z0, var2697=$r2, var3821=org.apache.dubbo.common.utils.NetUtils, var3781=$r3, var2412=$r4, var1143=$r5, var3157=$i0, var3840=$i1, var2095=$r6, var3901=$r7}
; {org.apache.dubbo.rpc.protocol.AbstractProtocol=var3248, r8=var3865, org.apache.dubbo.common.URL=var2097, r0=var707, $r1=var3164, r9=var1575, $z0=var3773, $r2=var2697, org.apache.dubbo.common.utils.NetUtils=var3821, $r3=var3781, $r4=var2412, $r5=var1143, $i0=var3157, $i1=var3840, $r6=var2095, $r7=var3901}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.AbstractProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("bind.ip", $r1);	$z0 = virtualinvoke r0.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("anyhost", 0);	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getIpByHost(java.lang.String)>(r9);	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>();	$i1 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 2