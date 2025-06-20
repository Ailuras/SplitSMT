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

(declare-sort var2710 0)
(declare-sort var3708 0)
(declare-sort var1843 0)
(declare-sort var3627 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2710 String) String)
(declare-fun var1843_isEmpty/-813097145 (String) Bool)
(declare-fun var3627_parseBoolean/746105335 (String) Bool)
(declare-const null-var2710 var2710)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3735 var2710) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3735 null-var2710)))
(declare-const var1933 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1933 null-String)))
(declare-const var2129 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var2129 null-Bool)))
(assert true)
(define-const var2464 String (getParameter/-1307325648 var3735 var1933)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3462 Bool (var1843_isEmpty/-813097145 var2464)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert (= (ite var3462 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3251 Bool (var3627_parseBoolean/746105335 var2464)) ; Statement: $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1843_isEmpty/-813097145=([java.lang.String], boolean), var3627_parseBoolean/746105335=([java.lang.String], boolean)}
; {var2710=org.apache.dubbo.common.URL, var3735=r0, var1933=r1, var3708=null_type, var2129=z1, var2464=r2, var1843=org.apache.dubbo.common.utils.StringUtils, var3462=$z0, var3627=java.lang.Boolean, var3251=$z2}
; {org.apache.dubbo.common.URL=var2710, r0=var3735, r1=var1933, null_type=var3708, z1=var2129, r2=var2464, org.apache.dubbo.common.utils.StringUtils=var1843, $z0=var3462, java.lang.Boolean=var3627, $z2=var3251}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	z1 := @parameter1: boolean;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	$z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	return $z2
;block_num 3