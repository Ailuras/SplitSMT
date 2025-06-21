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

(declare-sort var871 0)
(declare-sort var2226 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLevel/-1526844966 (var2226) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const null-var2226 var2226)
(declare-const var2292 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2292 null-String)))
(declare-const var47 var2226) ; Statement: r0 := @parameter1: org.apache.dubbo.qos.api.PermissionLevel 
(assert (not (= var47 null-var2226)))
(assert true)
(define-const var1109 Int (getLevel/-1526844966 var47)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.qos.api.PermissionLevel: int getLevel()>() 
(define-const var2257 String (String_valueOf/1240665136 var1109)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
(assert true)
(define-const var3709 String (trim/-847153721 var2292)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var2938 Bool (= var2257 var3709)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getLevel/-1526844966=([org.apache.dubbo.qos.api.PermissionLevel], int), String_valueOf/1240665136=([int], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2292=r1, var871=null_type, var2226=org.apache.dubbo.qos.api.PermissionLevel, var47=r0, var1109=$i0, var2257=$r3, var3709=$r2, var2938=$z0}
; {r1=var2292, null_type=var871, org.apache.dubbo.qos.api.PermissionLevel=var2226, r0=var47, $i0=var1109, $r3=var2257, $r2=var3709, $z0=var2938}
;seq <java.lang.String: java.lang.String valueOf(int)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.qos.api.PermissionLevel;	$i0 = virtualinvoke r0.<org.apache.dubbo.qos.api.PermissionLevel: int getLevel()>();	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1