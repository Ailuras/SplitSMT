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

(declare-sort var2522 0)
(declare-sort var1185 0)
(declare-sort var2054 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2522 String String) String)
(declare-fun var2054_isEmpty/-813097145 (String) Bool)
(declare-const null-var2522 var2522)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1600 var2522) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1600 null-var2522)))
(declare-const var2438 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2438 null-String)))
(declare-const var856 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var856 null-String)))
(declare-const var2959 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var2959 null-Bool)))
(assert true)
(define-const var2609 String (getServiceParameter/1782298180 var1600 var2438 var856)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var168 Bool (var2054_isEmpty/-813097145 var2609)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (= (ite var168 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2425 Bool var2959) ; Statement: $z2 = z1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2054_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2522=org.apache.dubbo.common.URL, var1600=r0, var2438=r1, var1185=null_type, var856=r2, var2959=z1, var2609=r3, var2054=org.apache.dubbo.common.utils.StringUtils, var168=$z0, var2425=$z2}
; {org.apache.dubbo.common.URL=var2522, r0=var1600, r1=var2438, null_type=var1185, r2=var856, z1=var2959, r3=var2609, org.apache.dubbo.common.utils.StringUtils=var2054, $z0=var168, $z2=var2425}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z2 = z1;	goto [?= return $z2];	return $z2
;block_num 3