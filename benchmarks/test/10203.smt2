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

(declare-sort var2465 0)
(declare-sort var320 0)
(declare-sort var1180 0)
(declare-sort var1485 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2465 String) String)
(declare-fun var320_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1485_parseServices/-1648093094 (String) var1180)
(declare-const null-var2465 var2465)
(declare-const var1922 var2465) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1922 null-var2465)))
(assert true)
(define-const var3656 String (getParameter/-1307325648 var1922 "provided-by")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("provided-by") 
(define-const var1094 Bool (var320_isBlank/-523695098 (cast-from-String-to-String var3656))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping: java.util.Set parseServices(java.lang.String)>(r1) 
(assert (= (ite var1094 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2373 var1180 (var1485_parseServices/-1648093094 var3656)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping: java.util.Set parseServices(java.lang.String)>(r1) 
 ; Statement: return $r2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var320_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1485_parseServices/-1648093094=([java.lang.String], java.util.Set)}
; {var2465=org.apache.dubbo.common.URL, var1922=r0, var3656=r1, var320=org.apache.dubbo.common.utils.StringUtils, var1094=$z0, var1180=java.util.Set, var1485=org.apache.dubbo.metadata.AbstractServiceNameMapping, var2373=$r2}
; {org.apache.dubbo.common.URL=var2465, r0=var1922, r1=var3656, org.apache.dubbo.common.utils.StringUtils=var320, $z0=var1094, java.util.Set=var1180, org.apache.dubbo.metadata.AbstractServiceNameMapping=var1485, $r2=var2373}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("provided-by");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping: java.util.Set parseServices(java.lang.String)>(r1);	$r2 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping: java.util.Set parseServices(java.lang.String)>(r1);	return $r2
;block_num 2