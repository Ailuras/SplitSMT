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

(declare-sort var1780 0)
(declare-sort var2496 0)
(declare-sort var3849 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var1780 String String) String)
(declare-fun var3849_isEmpty/-813097145 (String) Bool)
(declare-const null-var1780 var1780)
(declare-const null-String String)
(declare-const var1255 var1780) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1255 null-var1780)))
(declare-const var3646 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3646 null-String)))
(declare-const var3316 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3316 null-String)))
(declare-const var1132 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var1132 null-String)))
(assert true)
(define-const var3533 String (getMethodParameter/2015795402 var1255 var3646 var3316)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2010 Bool (var3849_isEmpty/-813097145 var3533)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (not (= (ite var2010 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2062 String var1132) ; Statement: $r5 = r4 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3849_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1780=org.apache.dubbo.common.URL, var1255=r0, var3646=r1, var2496=null_type, var3316=r2, var1132=r4, var3533=r3, var3849=org.apache.dubbo.common.utils.StringUtils, var2010=$z0, var2062=$r5}
; {org.apache.dubbo.common.URL=var1780, r0=var1255, r1=var3646, null_type=var2496, r2=var3316, r4=var1132, r3=var3533, org.apache.dubbo.common.utils.StringUtils=var3849, $z0=var2010, $r5=var2062}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r5 = r3;	$r5 = r4;	goto [?= return $r5];	return $r5
;block_num 3