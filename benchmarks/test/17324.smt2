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

(declare-sort var669 0)
(declare-sort var2557 0)
(declare-sort var3004 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var669_mediaType/-2049250705 (var669) var3004)
(declare-fun getName/761802846 (var3004) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var669 var669)
(declare-const null-String String)
(declare-const var1061 var669) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.CodecMediaType 
(assert (not (= var1061 null-var669)))
(declare-const var2617 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2617 null-String)))
(define-const var3859 var3004 (var669_mediaType/-2049250705 var1061)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.message.CodecMediaType: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var2009 String (getName/761802846 var3859)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var1340 Bool (startsWith/-1785782452 var2617 var2009)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {var669_mediaType/-2049250705=([org.apache.dubbo.remoting.http12.message.CodecMediaType], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var669=org.apache.dubbo.remoting.http12.message.CodecMediaType, var1061=r1, var2617=r0, var2557=null_type, var3004=org.apache.dubbo.remoting.http12.message.MediaType, var3859=$r2, var2009=$r3, var1340=$z0}
; {org.apache.dubbo.remoting.http12.message.CodecMediaType=var669, r1=var1061, r0=var2617, null_type=var2557, org.apache.dubbo.remoting.http12.message.MediaType=var3004, $r2=var3859, $r3=var2009, $z0=var1340}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.CodecMediaType;	r0 := @parameter0: java.lang.String;	$r2 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.message.CodecMediaType: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	return $z0
;block_num 1