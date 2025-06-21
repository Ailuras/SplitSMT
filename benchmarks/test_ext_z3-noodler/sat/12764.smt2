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

(declare-sort var568 0)
(declare-sort var2892 0)
(declare-sort var562 0)
(declare-sort var1104 0)
(declare-sort var1327 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun acceptForeignIpWhitelist/1445682019 (var568) String)
(declare-fun var562_isEmpty/-813097145 (String) Bool)
(declare-fun getHostAddress/1493983505 (var2892) String)
(declare-fun whitelistPredicate/1445682019 (var568) var1104)
(declare-fun var1104_test/1046155075 (var1104 var1327) Bool)
(declare-fun cast-from-String-to-var1327 (String) var1327)
(declare-const null-var568 var568)
(declare-const null-var2892 var2892)
(declare-const var2492 var568) ; Statement: r0 := @this: org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler 
(assert (not (= var2492 null-var568)))
(declare-const var238 var2892) ; Statement: r2 := @parameter0: java.net.InetAddress 
(assert (not (= var238 null-var2892)))
(define-const var2935 String (acceptForeignIpWhitelist/1445682019 var2492)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler: java.lang.String acceptForeignIpWhitelist> 
(define-const var2102 Bool (var562_isEmpty/-813097145 var2935)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto r3 = virtualinvoke r2.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(assert (= (ite var2102 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var893 String (getHostAddress/1493983505 var238)) ; Statement: r3 = virtualinvoke r2.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var2361 var1104 (whitelistPredicate/1445682019 var2492)) ; Statement: $r4 = r0.<org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler: java.util.function.Predicate whitelistPredicate> 
(define-const var277 Bool (var1104_test/1046155075 var2361 (cast-from-String-to-var1327 var893))) ; Statement: $z1 = interfaceinvoke $r4.<java.util.function.Predicate: boolean test(java.lang.Object)>(r3) 
 ; Statement: return $z1 
(check-sat)
; {acceptForeignIpWhitelist/1445682019=([org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler], java.lang.String), var562_isEmpty/-813097145=([java.lang.String], boolean), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), whitelistPredicate/1445682019=([org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler], java.util.function.Predicate), var1104_test/1046155075=([java.util.function.Predicate, java.lang.Object], boolean), cast-from-String-to-var1327=([java.lang.String], java.lang.Object)}
; {var568=org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler, var2492=r0, var2892=java.net.InetAddress, var238=r2, var2935=$r1, var562=org.apache.dubbo.common.utils.StringUtils, var2102=$z0, var893=r3, var1104=java.util.function.Predicate, var2361=$r4, var1327=java.lang.Object, var277=$z1}
; {org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler=var568, r0=var2492, java.net.InetAddress=var2892, r2=var238, $r1=var2935, org.apache.dubbo.common.utils.StringUtils=var562, $z0=var2102, r3=var893, java.util.function.Predicate=var1104, $r4=var2361, java.lang.Object=var1327, $z1=var277}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler;	r2 := @parameter0: java.net.InetAddress;	$r1 = r0.<org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler: java.lang.String acceptForeignIpWhitelist>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto r3 = virtualinvoke r2.<java.net.InetAddress: java.lang.String getHostAddress()>();	r3 = virtualinvoke r2.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r4 = r0.<org.apache.dubbo.qos.server.handler.ForeignHostPermitHandler: java.util.function.Predicate whitelistPredicate>;	$z1 = interfaceinvoke $r4.<java.util.function.Predicate: boolean test(java.lang.Object)>(r3);	return $z1
;block_num 2