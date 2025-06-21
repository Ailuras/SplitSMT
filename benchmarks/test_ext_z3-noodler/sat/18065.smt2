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

(declare-sort var164 0)
(declare-sort var924 0)
(declare-sort var338 0)
(declare-sort var2714 0)
(declare-sort var3717 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun headers/-562224243 (var164) var924)
(declare-fun var924_getFirst/-2132893997 (var924 String) String)
(declare-fun var338_isEmpty/-813097145 (String) Bool)
(declare-fun var3717_parseHttpDate/1679869219 (String) var2714)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var164 var164)
(declare-const null-String String)
(declare-const var3725 var164) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var3725 null-var164)))
(declare-const var1916 String) ; Statement: r1 := @parameter0: java.lang.CharSequence 
(assert (not (= var1916 null-String)))
(define-const var2000 var924 (headers/-562224243 var3725)) ; Statement: $r2 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: org.apache.dubbo.remoting.http12.HttpHeaders headers> 
(define-const var3491 String (var924_getFirst/-2132893997 var2000 var1916)) ; Statement: r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.http12.HttpHeaders: java.lang.String getFirst(java.lang.CharSequence)>(r1) 
(define-const var339 Bool (var338_isEmpty/-813097145 var3491)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r3) 
(assert (= (ite var339 1 0) 0)) ; Cond: $z0 == 0 
(define-const var431 var2714 (var3717_parseHttpDate/1679869219 (cast-from-String-to-String var3491))) ; Statement: $r4 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r3) 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {headers/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], org.apache.dubbo.remoting.http12.HttpHeaders), var924_getFirst/-2132893997=([org.apache.dubbo.remoting.http12.HttpHeaders, java.lang.CharSequence], java.lang.String), var338_isEmpty/-813097145=([java.lang.String], boolean), var3717_parseHttpDate/1679869219=([java.lang.CharSequence], java.util.Date), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var164=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3725=r0, var1916=r1, var924=org.apache.dubbo.remoting.http12.HttpHeaders, var2000=$r2, var3491=r3, var338=org.apache.dubbo.common.utils.StringUtils, var339=$z0, var2714=java.util.Date, var3717=io.netty.handler.codec.DateFormatter, var431=$r4}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var164, r0=var3725, r1=var1916, org.apache.dubbo.remoting.http12.HttpHeaders=var924, $r2=var2000, r3=var3491, org.apache.dubbo.common.utils.StringUtils=var338, $z0=var339, java.util.Date=var2714, io.netty.handler.codec.DateFormatter=var3717, $r4=var431}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r1 := @parameter0: java.lang.CharSequence;	$r2 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: org.apache.dubbo.remoting.http12.HttpHeaders headers>;	r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.http12.HttpHeaders: java.lang.String getFirst(java.lang.CharSequence)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r3);	$r4 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r3);	return $r4
;block_num 3