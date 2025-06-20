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

(declare-sort var2946 0)
(declare-sort var1322 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1322 String) String)
(declare-const null-var2946 var2946)
(declare-const null-var1322 var1322)
(declare-const var1576 var2946) ; Statement: r4 := @this: org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol 
(assert (not (= var1576 null-var2946)))
(declare-const var385 var1322) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var385 null-var1322)))
(assert true)
(define-const var1943 String (getParameter/-1307325648 var385 "scope")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope") 
(define-const var3722 String "local") ; Statement: $r2 = "local" 
(assert true)
(define-const var1137 Bool (= var3722 var1943)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto return 1 
(assert (not (= (ite var1137 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var2946=org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol, var1576=r4, var1322=org.apache.dubbo.common.URL, var385=r0, var1943=r1, var3722=$r2, var1137=$z0}
; {org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol=var2946, r4=var1576, org.apache.dubbo.common.URL=var1322, r0=var385, r1=var1943, $r2=var3722, $z0=var1137}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope");	$r2 = "local";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto return 1;	return 1
;block_num 2