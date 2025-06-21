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

(declare-sort var2719 0)
(declare-sort var3321 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun setContentType0/-547622184 (var2719 String) void)
(declare-fun charset/-562224243 (var2719) String)
(declare-const null-var2719 var2719)
(declare-const null-String String)
(declare-const var3584 var2719) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var3584 null-var2719)))
(declare-const var2930 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2930 null-String)))
 ; Statement: if r1 != null goto $r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
(assert (not (= var2930 null-String))) ; Cond: r1 != null 
(assert true)
(define-const var3762 String (trim/-847153721 var2930)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
(assert true) ; Non Conditional
(assert true)
;(assert (setContentType0/-547622184 var3584 var3762)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: void setContentType0(java.lang.String)>($r2) 

(declare-const var3584!1 var2719)
(declare-const var3762!1 String)
(declare-const var3584!2 var2719)
(assert (not (= var3584!2 null-var2719)))
(assert (= (charset/-562224243 var3584!2) null-String)) ; Statement: r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = null 
 ; Statement: return 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), setContentType0/-547622184=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, java.lang.String], void), charset/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String)}
; {var2719=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3584=r0, var2930=r1, var3321=null_type, var3762=$r2}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var2719, r0=var3584, r1=var2930, null_type=var3321, $r2=var3762}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r1 := @parameter0: java.lang.String;	if r1 != null goto $r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	specialinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: void setContentType0(java.lang.String)>($r2);	r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = null;	return
;block_num 3