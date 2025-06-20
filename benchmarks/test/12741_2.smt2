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

(declare-sort var2139 0)
(declare-sort var3589 0)
(declare-sort var1713 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun acceptForeignIpWhitelist/1445682019 (var2139) String)
(declare-fun var1713_isEmpty/-813097145 (String) Bool)
(declare-const null-var2139 var2139)
(declare-const null-var3589 var3589)
(declare-const var2034 var2139) ; Statement: r0 := @this: org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler 
(assert (not (= var2034 null-var2139)))
(declare-const var2067 var3589) ; Statement: r2 := @parameter0: java.net.InetAddress 
(assert (not (= var2067 null-var3589)))
(define-const var2651 String (acceptForeignIpWhitelist/1445682019 var2034)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler: java.lang.String acceptForeignIpWhitelist> 
(define-const var702 Bool (var1713_isEmpty/-813097145 var2651)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto r3 = virtualinvoke r2.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(assert (not (= (ite var702 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {acceptForeignIpWhitelist/1445682019=([org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler], java.lang.String), var1713_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2139=org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler, var2034=r0, var3589=java.net.InetAddress, var2067=r2, var2651=$r1, var1713=org.apache.dubbo.common.utils.StringUtils, var702=$z0}
; {org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler=var2139, r0=var2034, java.net.InetAddress=var3589, r2=var2067, $r1=var2651, org.apache.dubbo.common.utils.StringUtils=var1713, $z0=var702}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler;	r2 := @parameter0: java.net.InetAddress;	$r1 = r0.<org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler: java.lang.String acceptForeignIpWhitelist>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto r3 = virtualinvoke r2.<java.net.InetAddress: java.lang.String getHostAddress()>();	return 0
;block_num 2