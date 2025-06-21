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

(declare-sort var3730 0)
(declare-sort var315 0)
(declare-sort var1750 0)
(declare-sort var1163 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1750_getUrl/-275947851 (var1750) var315)
(declare-fun cast-from-var3730-to-var1750 (var3730) var1750)
(declare-fun getParameter/-1307325648 (var315 String) String)
(declare-fun var1163_isEmpty/-813097145 (String) Bool)
(declare-const null-var3730 var3730)
(declare-const var121 var3730) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var121 null-var3730)))
(define-const var2099 var315 (var1750_getUrl/-275947851 (cast-from-var3730-to-var1750 var121))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2727 String (getParameter/-1307325648 var2099 "dubbo.tag")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
(define-const var1938 Bool (var1163_isEmpty/-813097145 var2727)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {var1750_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3730-to-var1750=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1163_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3730=org.apache.dubbo.rpc.Invoker, var121=r0, var315=org.apache.dubbo.common.URL, var1750=org.apache.dubbo.common.Node, var2099=$r1, var2727=$r2, var1163=org.apache.dubbo.common.utils.StringUtils, var1938=$z0}
; {org.apache.dubbo.rpc.Invoker=var3730, r0=var121, org.apache.dubbo.common.URL=var315, org.apache.dubbo.common.Node=var1750, $r1=var2099, $r2=var2727, org.apache.dubbo.common.utils.StringUtils=var1163, $z0=var1938}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2);	return $z0
;block_num 1