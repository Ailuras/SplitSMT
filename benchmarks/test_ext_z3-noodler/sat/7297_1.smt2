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

(declare-sort var2734 0)
(declare-sort var434 0)
(declare-sort var440 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2734 String String) String)
(declare-fun var440_isEmpty/-813097145 (String) Bool)
(declare-const null-var2734 var2734)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3632 var2734) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3632 null-var2734)))
(declare-const var794 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var794 null-String)))
(declare-const var1036 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1036 null-String)))
(declare-const var2415 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var2415 null-Bool)))
(assert true)
(define-const var2185 String (getMethodParameter/2015795402 var3632 var794 var1036)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2490 Bool (var440_isEmpty/-813097145 var2185)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (= (ite var2490 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var751 Bool var2415) ; Statement: $z2 = z1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var440_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2734=org.apache.dubbo.common.URL, var3632=r0, var794=r1, var434=null_type, var1036=r2, var2415=z1, var2185=r3, var440=org.apache.dubbo.common.utils.StringUtils, var2490=$z0, var751=$z2}
; {org.apache.dubbo.common.URL=var2734, r0=var3632, r1=var794, null_type=var434, r2=var1036, z1=var2415, r3=var2185, org.apache.dubbo.common.utils.StringUtils=var440, $z0=var2490, $z2=var751}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z2 = z1;	goto [?= return $z2];	return $z2
;block_num 3