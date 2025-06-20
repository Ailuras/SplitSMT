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

(declare-sort var1342 0)
(declare-sort var1756 0)
(declare-sort var3304 0)
(declare-sort var3586 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3304_getUrl/-275947851 (var3304) var1756)
(declare-fun cast-from-var1342-to-var3304 (var1342) var3304)
(declare-fun getParameter/-1307325648 (var1756 String) String)
(declare-fun var3586_isEmpty/-813097145 (String) Bool)
(declare-const null-var1342 var1342)
(declare-const var2099 var1342) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2099 null-var1342)))
(define-const var1826 var1756 (var3304_getUrl/-275947851 (cast-from-var1342-to-var3304 var2099))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1526 String (getParameter/-1307325648 var1826 "dubbo.tag")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
(define-const var2216 Bool (var3586_isEmpty/-813097145 var1526)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {var3304_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1342-to-var3304=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3586_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1342=org.apache.dubbo.rpc.Invoker, var2099=r0, var1756=org.apache.dubbo.common.URL, var3304=org.apache.dubbo.common.Node, var1826=$r1, var1526=$r2, var3586=org.apache.dubbo.common.utils.StringUtils, var2216=$z0}
; {org.apache.dubbo.rpc.Invoker=var1342, r0=var2099, org.apache.dubbo.common.URL=var1756, org.apache.dubbo.common.Node=var3304, $r1=var1826, $r2=var1526, org.apache.dubbo.common.utils.StringUtils=var3586, $z0=var2216}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2);	return $z0
;block_num 1