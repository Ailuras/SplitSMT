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

(declare-sort var3803 0)
(declare-sort var2223 0)
(declare-sort var2222 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var3803 String String String) String)
(declare-fun var2222_isEmpty/-813097145 (String) Bool)
(declare-const null-var3803 var3803)
(declare-const null-String String)
(declare-const var0 var3803) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var0 null-var3803)))
(declare-const var1092 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1092 null-String)))
(declare-const var704 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var704 null-String)))
(declare-const var3052 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3052 null-String)))
(declare-const var1308 String) ; Statement: r5 := @parameter3: java.lang.String 
(assert (not (= var1308 null-String)))
(assert true)
(define-const var3388 String (getServiceMethodParameter/-1810918120 var0 var1092 var704 var3052)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var1312 Bool (var2222_isEmpty/-813097145 var3388)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r6 = r4 
(assert (not (= (ite var1312 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1838 String var1308) ; Statement: $r6 = r5 
 ; Statement: goto [?= return $r6] 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var2222_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3803=org.apache.dubbo.common.URL, var0=r0, var1092=r1, var2223=null_type, var704=r2, var3052=r3, var1308=r5, var3388=r4, var2222=org.apache.dubbo.common.utils.StringUtils, var1312=$z0, var1838=$r6}
; {org.apache.dubbo.common.URL=var3803, r0=var0, r1=var1092, null_type=var2223, r2=var704, r3=var3052, r5=var1308, r4=var3388, org.apache.dubbo.common.utils.StringUtils=var2222, $z0=var1312, $r6=var1838}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r5 := @parameter3: java.lang.String;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r6 = r4;	$r6 = r5;	goto [?= return $r6];	return $r6
;block_num 3