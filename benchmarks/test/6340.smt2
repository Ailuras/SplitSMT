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

(declare-sort var3532 0)
(declare-sort var1794 0)
(declare-sort var2761 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3532 String) String)
(declare-fun var2761_isEmpty/-813097145 (String) Bool)
(declare-const null-var3532 var3532)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1378 var3532) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1378 null-var3532)))
(declare-const var15 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var15 null-String)))
(declare-const var1141 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var1141 null-Bool)))
(assert true)
(define-const var3781 String (getParameter/-1307325648 var1378 var15)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1202 Bool (var2761_isEmpty/-813097145 var3781)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert (not (= (ite var1202 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var223 Bool var1141) ; Statement: $z2 = z1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2761_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3532=org.apache.dubbo.common.URL, var1378=r0, var15=r1, var1794=null_type, var1141=z1, var3781=r2, var2761=org.apache.dubbo.common.utils.StringUtils, var1202=$z0, var223=$z2}
; {org.apache.dubbo.common.URL=var3532, r0=var1378, r1=var15, null_type=var1794, z1=var1141, r2=var3781, org.apache.dubbo.common.utils.StringUtils=var2761, $z0=var1202, $z2=var223}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	z1 := @parameter1: boolean;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	$z2 = z1;	goto [?= return $z2];	return $z2
;block_num 3