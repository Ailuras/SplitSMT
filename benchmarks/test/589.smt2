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

(declare-sort var3646 0)
(declare-sort var70 0)
(declare-sort var2054 0)
(declare-sort var2966 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun configuratorUrl/338141869 (var3646) var70)
(declare-fun getParameter/-1307325648 (var70 String) String)
(declare-fun var2054_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getUsername/657618160 (var70) String)
(declare-fun getApplication/1867665513 (var70 String) String)
(declare-fun getServiceKey/1456125852 (var70) String)
(declare-const null-var3646 var3646)
(declare-const null-var70 var70)
(declare-const null-String String)
(declare-const var3736 var3646) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator 
(assert (not (= var3736 null-var3646)))
(declare-const var366 var70) ; Statement: r6 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var366 null-var70)))
(define-const var1934 var70 (configuratorUrl/338141869 var3736)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var235 String (getParameter/-1307325648 var1934 "providerAddresses")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("providerAddresses") 
(define-const var2827 Bool (var2054_isNotEmpty/-1251449450 var235)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert (= (ite var2827 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3236 var70 (configuratorUrl/338141869 var3736)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(define-const var413 var70 (configuratorUrl/338141869 var3736)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var1732 String (getUsername/657618160 var413)) ; Statement: $r5 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(assert true)
(define-const var709 String (getApplication/1867665513 var3236 var1732)) ; Statement: $r23 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication(java.lang.String)>($r5) 
(assert true)
(define-const var3750 String (getUsername/657618160 var366)) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(assert true)
(define-const var2273 String (getApplication/1867665513 var366 var3750)) ; Statement: $r24 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getApplication(java.lang.String)>($r7) 
 ; Statement: if $r23 == null goto $r41 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert (= var709 null-String)) ; Cond: $r23 == null 
(define-const var1897 var70 (configuratorUrl/338141869 var3736)) ; Statement: $r41 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var3624 String (getServiceKey/1456125852 var1897)) ; Statement: $r42 = virtualinvoke $r41.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2544 String (getServiceKey/1456125852 var366)) ; Statement: $r43 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(define-const var1545 String "*") ; Statement: $r44 = "*" 
(assert true)
(define-const var728 Bool (= var1545 var3624)) ; Statement: $z10 = virtualinvoke $r44.<java.lang.String: boolean equals(java.lang.Object)>($r42) 
 ; Statement: if $z10 != 0 goto return 1 
(assert (not (= (ite var728 1 0) 0))) ; Cond: $z10 != 0 
 ; Statement: return 1 
(check-sat)
; {configuratorUrl/338141869=([org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator], org.apache.dubbo.common.URL), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2054_isNotEmpty/-1251449450=([java.lang.String], boolean), getUsername/657618160=([org.apache.dubbo.common.URL], java.lang.String), getApplication/1867665513=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3646=org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, var3736=r0, var70=org.apache.dubbo.common.URL, var366=r6, var1934=$r1, var235=r2, var2054=org.apache.dubbo.common.utils.StringUtils, var2827=$z0, var3236=$r4, var413=$r3, var1732=$r5, var709=$r23, var3750=$r7, var2273=$r24, var2966=null_type, var1897=$r41, var3624=$r42, var2544=$r43, var1545=$r44, var728=$z10}
; {org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator=var3646, r0=var3736, org.apache.dubbo.common.URL=var70, r6=var366, $r1=var1934, r2=var235, org.apache.dubbo.common.utils.StringUtils=var2054, $z0=var2827, $r4=var3236, $r3=var413, $r5=var1732, $r23=var709, $r7=var3750, $r24=var2273, null_type=var2966, $r41=var1897, $r42=var3624, $r43=var2544, $r44=var1545, $z10=var728}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator;	r6 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("providerAddresses");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r4 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r3 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r5 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$r23 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication(java.lang.String)>($r5);	$r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$r24 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getApplication(java.lang.String)>($r7);	if $r23 == null goto $r41 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r41 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r42 = virtualinvoke $r41.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r43 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r44 = "*";	$z10 = virtualinvoke $r44.<java.lang.String: boolean equals(java.lang.Object)>($r42);	if $z10 != 0 goto return 1;	return 1
;block_num 4