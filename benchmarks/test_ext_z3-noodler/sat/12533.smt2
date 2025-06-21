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

(declare-sort var1640 0)
(declare-sort var3984 0)
(declare-sort var1810 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var1640 String String) String)
(declare-fun var1810_isEmpty/-813097145 (String) Bool)
(declare-const null-var1640 var1640)
(declare-const null-String String)
(declare-const var1226 var1640) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1226 null-var1640)))
(declare-const var3164 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3164 null-String)))
(declare-const var2331 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2331 null-String)))
(declare-const var707 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var707 null-String)))
(assert true)
(define-const var909 String (getServiceParameter/1782298180 var1226 var3164 var2331)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2854 Bool (var1810_isEmpty/-813097145 var909)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (not (= (ite var2854 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2342 String var707) ; Statement: $r5 = r4 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1810_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1640=org.apache.dubbo.common.URL, var1226=r0, var3164=r1, var3984=null_type, var2331=r2, var707=r4, var909=r3, var1810=org.apache.dubbo.common.utils.StringUtils, var2854=$z0, var2342=$r5}
; {org.apache.dubbo.common.URL=var1640, r0=var1226, r1=var3164, null_type=var3984, r2=var2331, r4=var707, r3=var909, org.apache.dubbo.common.utils.StringUtils=var1810, $z0=var2854, $r5=var2342}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r5 = r3;	$r5 = r4;	goto [?= return $r5];	return $r5
;block_num 3