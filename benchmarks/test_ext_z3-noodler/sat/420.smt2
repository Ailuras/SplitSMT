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

(declare-sort var519 0)
(declare-sort var3666 0)
(declare-sort var584 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun configuratorUrl/338141869 (var519) var3666)
(declare-fun getPort/20614931 (var3666) Int)
(declare-fun getSide/-1479508364 (var3666 String) String)
(declare-fun var584_getLocalHost/-1653363627 () String)
(declare-fun configureIfMatch/535684361 (var519 String var3666) var3666)
(declare-const null-var519 var519)
(declare-const null-var3666 var3666)
(declare-const var1857 var519) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator 
(assert (not (= var1857 null-var519)))
(declare-const var2894 var3666) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2894 null-var3666)))
(define-const var917 var3666 (configuratorUrl/338141869 var1857)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var2999 Int (getPort/20614931 var917)) ; Statement: $i0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: int getPort()>() 
 ; Statement: if $i0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("provider") 
(assert (= var2999 0)) ; Cond: $i0 == 0 
(assert true)
(define-const var845 String (getSide/-1479508364 var2894 "provider")) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("provider") 
(assert true)
(define-const var2031 Bool (= var845 "consumer")) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>("consumer") 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("consumer") 
(assert (not (= (ite var2031 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1074 String var584_getLocalHost/-1653363627) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var3616 var3666 (configureIfMatch/535684361 var1857 var1074 var2894)) ; Statement: $r7 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configureIfMatch(java.lang.String,org.apache.dubbo.common.URL)>($r6, r2) 
 ; Statement: return $r7 
(check-sat)
; {configuratorUrl/338141869=([org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator], org.apache.dubbo.common.URL), getPort/20614931=([org.apache.dubbo.common.URL], int), getSide/-1479508364=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var584_getLocalHost/-1653363627=([], java.lang.String), configureIfMatch/535684361=([org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, java.lang.String, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL)}
; {var519=org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, var1857=r0, var3666=org.apache.dubbo.common.URL, var2894=r2, var917=$r1, var2999=$i0, var845=$r3, var2031=$z0, var584=org.apache.dubbo.common.utils.NetUtils, var1074=$r6, var3616=$r7}
; {org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator=var519, r0=var1857, org.apache.dubbo.common.URL=var3666, r2=var2894, $r1=var917, $i0=var2999, $r3=var845, $z0=var2031, org.apache.dubbo.common.utils.NetUtils=var584, $r6=var1074, $r7=var3616}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$i0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: int getPort()>();	if $i0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("provider");	$r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("provider");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>("consumer");	if $z0 == 0 goto $r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("consumer");	$r6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r7 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configureIfMatch(java.lang.String,org.apache.dubbo.common.URL)>($r6, r2);	return $r7
;block_num 3