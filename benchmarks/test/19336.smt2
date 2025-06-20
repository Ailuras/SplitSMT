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

(declare-sort var3270 0)
(declare-sort var2818 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/1783180996 (var3270) var2818)
(declare-fun getSide/-1479508364 (var2818 String) String)
(declare-const null-var3270 var3270)
(declare-const var46 var3270) ; Statement: r0 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var46 null-var3270)))
(assert true)
(define-const var1506 var2818 (getUrl/1783180996 var46)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3043 String (getSide/-1479508364 var1506 "provider")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("provider") 
(assert true)
(define-const var766 Bool (= var3043 "consumer")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("consumer") 
 ; Statement: return $z0 
(check-sat)
; {getUrl/1783180996=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getSide/-1479508364=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var3270=org.apache.dubbo.rpc.RpcServiceContext, var46=r0, var2818=org.apache.dubbo.common.URL, var1506=$r1, var3043=$r2, var766=$z0}
; {org.apache.dubbo.rpc.RpcServiceContext=var3270, r0=var46, org.apache.dubbo.common.URL=var2818, $r1=var1506, $r2=var3043, $z0=var766}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("provider");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("consumer");	return $z0
;block_num 1