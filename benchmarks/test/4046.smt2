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

(declare-sort var1242 0)
(declare-sort var1251 0)
(declare-sort var3463 0)
(declare-sort var2170 0)
(declare-sort var1568 0)
(declare-sort var3911 0)
(declare-sort var596 0)
(declare-sort var260 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3463_newBuilder/1944521071 () var1251)
(declare-fun isIgnoreExceptions/1480944329 (var2170) Bool)
(declare-fun cast-from-var1242-to-var2170 (var1242) var2170)
(declare-fun setIgnoreExceptions/133092585 (var1251 Bool) var260)
(declare-fun getLayout/147613089 (var2170) var1568)
(declare-fun setLayout/-1383613611 (var1251 var1568) var260)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/877129339 (var2170) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun setName/-696825319 (var1251 String) var260)
(declare-fun getConfiguration/-284480103 (var2170) var3911)
(declare-fun setConfiguration/-2108388827 (var1251 var3911) var260)
(declare-fun isBufferedIo/-388347654 (var2170) Bool)
(declare-fun setBufferedIo/1264768921 (var1251 Bool) var2170)
(declare-fun getBufferSize/-556463341 (var2170) Int)
(declare-fun setBufferSize/1727932572 (var1251 Int) var2170)
(declare-fun isImmediateFlush/-1894601268 (var2170) Bool)
(declare-fun setImmediateFlush/1884817927 (var1251 Bool) var2170)
(declare-fun fileName/-1415805022 (var1242) String)
(declare-fun withFileName/2120341355 (var1251 String) var1251)
(declare-fun append/-1415805022 (var1242) Bool)
(declare-fun withAppend/934910047 (var1251 Bool) var1251)
(declare-fun locking/-1415805022 (var1242) Bool)
(declare-fun withLocking/598120124 (var1251 Bool) var1251)
(declare-fun build/797536208 (var1251) var3463)
(declare-const null-var1242 var1242)
(declare-const null-String String)
(declare-const var2737 var1242) ; Statement: r1 := @this: org.apache.dubbo.common.utils.DubboAppender$Builder 
(assert (not (= var2737 null-var1242)))
(define-const var1756 var1251 var3463_newBuilder/1944521071) ; Statement: r0 = staticinvoke <org.apache.logging.log4j.core.appender.FileAppender: org.apache.logging.log4j.core.appender.FileAppender$Builder newBuilder()>() 
(assert true)
(define-const var3091 Bool (isIgnoreExceptions/1480944329 (cast-from-var1242-to-var2170 var2737))) ; Statement: $z0 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean isIgnoreExceptions()>() 
(assert true)
;(assert (setIgnoreExceptions/133092585 var1756 var3091)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setIgnoreExceptions(boolean)>($z0) 

(declare-const var1756!1 var1251)
(declare-const var3091!1 Bool)
(assert true)
(define-const var2071 var1568 (getLayout/147613089 (cast-from-var1242-to-var2170 var2737))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: org.apache.logging.log4j.core.Layout getLayout()>() 
(assert true)
;(assert (setLayout/-1383613611 var1756!1 var2071)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setLayout(org.apache.logging.log4j.core.Layout)>($r2) 

(declare-const var1756!2 var1251)
(declare-const var2071!1 var1568)
(define-const var2837 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2837)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2837!1 String)
(assert (= var2837!1 ""))
(assert true)
(define-const var2768 String (getName/877129339 (cast-from-var1242-to-var2170 var2737))) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: java.lang.String getName()>() 
(assert true)
(define-const var2847 String (append/672562846 var2837!1 var2768)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2837!2 String)
(assert (= var2837!2 (str.++ var2837!1 var2768)))
(assert true)
(define-const var3495 String (append/672562846 var2847 "-File")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-File") 
(declare-const var2847!1 String)
(assert (= var2847!1 (str.++ var2847 "-File")))
(assert true)
(define-const var3393 String (toString/-2075883882 var3495)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (setName/-696825319 var1756!2 var3393)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setName(java.lang.String)>($r7) 

(declare-const var1756!3 var1251)
(declare-const var3393!1 String)
(assert true)
(define-const var2959 var3911 (getConfiguration/-284480103 (cast-from-var1242-to-var2170 var2737))) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: org.apache.logging.log4j.core.config.Configuration getConfiguration()>() 
(assert true)
;(assert (setConfiguration/-2108388827 var1756!3 var2959)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setConfiguration(org.apache.logging.log4j.core.config.Configuration)>($r8) 

(declare-const var1756!4 var1251)
(declare-const var2959!1 var3911)
(assert true)
(define-const var3594 Bool (isBufferedIo/-388347654 (cast-from-var1242-to-var2170 var2737))) ; Statement: $z1 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean isBufferedIo()>() 
(assert true)
;(assert (setBufferedIo/1264768921 var1756!4 var3594)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder setBufferedIo(boolean)>($z1) 

(declare-const var1756!5 var1251)
(declare-const var3594!1 Bool)
(assert true)
(define-const var1396 Int (getBufferSize/-556463341 (cast-from-var1242-to-var2170 var2737))) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: int getBufferSize()>() 
(assert true)
;(assert (setBufferSize/1727932572 var1756!5 var1396)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder setBufferSize(int)>($i0) 

(declare-const var1756!6 var1251)
(declare-const var1396!1 Int)
(assert true)
(define-const var686 Bool (isImmediateFlush/-1894601268 (cast-from-var1242-to-var2170 var2737))) ; Statement: $z2 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean isImmediateFlush()>() 
(assert true)
;(assert (setImmediateFlush/1884817927 var1756!6 var686)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder setImmediateFlush(boolean)>($z2) 

(declare-const var1756!7 var1251)
(declare-const var686!1 Bool)
(define-const var1437 String (fileName/-1415805022 var2737)) ; Statement: $r9 = r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: java.lang.String fileName> 
 ; Statement: if $r9 == null goto $r12 = "dubbo.log" 
(assert (= var1437 null-String)) ; Cond: $r9 == null 
(define-const var66 String "dubbo.log") ; Statement: $r12 = "dubbo.log" 
 ; Statement: goto [?= virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withFileName(java.lang.String)>($r12)] 
(assert true) ; Non Conditional
(assert true)
;(assert (withFileName/2120341355 var1756!7 var66)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withFileName(java.lang.String)>($r12) 

(declare-const var1756!8 var1251)
(declare-const var66!1 String)
(define-const var2871 Bool (append/-1415805022 var2737)) ; Statement: $z3 = r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean append> 
(assert true)
;(assert (withAppend/934910047 var1756!8 var2871)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withAppend(boolean)>($z3) 

(declare-const var1756!9 var1251)
(declare-const var2871!1 Bool)
(define-const var332 Bool (locking/-1415805022 var2737)) ; Statement: $z4 = r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean locking> 
(assert true)
;(assert (withLocking/598120124 var1756!9 var332)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withLocking(boolean)>($z4) 

(declare-const var1756!10 var1251)
(declare-const var332!1 Bool)
(assert true)
(define-const var3808 var3463 (build/797536208 var1756!10)) ; Statement: $r10 = virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender build()>() 
 ; Statement: return $r10 
(check-sat)
; {var3463_newBuilder/1944521071=([], org.apache.logging.log4j.core.appender.FileAppender$Builder), isIgnoreExceptions/1480944329=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], boolean), cast-from-var1242-to-var2170=([org.apache.dubbo.common.utils.DubboAppender$Builder], org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder), setIgnoreExceptions/133092585=([org.apache.logging.log4j.core.appender.FileAppender$Builder, boolean], org.apache.logging.log4j.core.appender.AbstractAppender$Builder), getLayout/147613089=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], org.apache.logging.log4j.core.Layout), setLayout/-1383613611=([org.apache.logging.log4j.core.appender.FileAppender$Builder, org.apache.logging.log4j.core.Layout], org.apache.logging.log4j.core.appender.AbstractAppender$Builder), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/877129339=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), setName/-696825319=([org.apache.logging.log4j.core.appender.FileAppender$Builder, java.lang.String], org.apache.logging.log4j.core.appender.AbstractAppender$Builder), getConfiguration/-284480103=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], org.apache.logging.log4j.core.config.Configuration), setConfiguration/-2108388827=([org.apache.logging.log4j.core.appender.FileAppender$Builder, org.apache.logging.log4j.core.config.Configuration], org.apache.logging.log4j.core.appender.AbstractAppender$Builder), isBufferedIo/-388347654=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], boolean), setBufferedIo/1264768921=([org.apache.logging.log4j.core.appender.FileAppender$Builder, boolean], org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder), getBufferSize/-556463341=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], int), setBufferSize/1727932572=([org.apache.logging.log4j.core.appender.FileAppender$Builder, int], org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder), isImmediateFlush/-1894601268=([org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder], boolean), setImmediateFlush/1884817927=([org.apache.logging.log4j.core.appender.FileAppender$Builder, boolean], org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder), fileName/-1415805022=([org.apache.dubbo.common.utils.DubboAppender$Builder], java.lang.String), withFileName/2120341355=([org.apache.logging.log4j.core.appender.FileAppender$Builder, java.lang.String], org.apache.logging.log4j.core.appender.FileAppender$Builder), append/-1415805022=([org.apache.dubbo.common.utils.DubboAppender$Builder], boolean), withAppend/934910047=([org.apache.logging.log4j.core.appender.FileAppender$Builder, boolean], org.apache.logging.log4j.core.appender.FileAppender$Builder), locking/-1415805022=([org.apache.dubbo.common.utils.DubboAppender$Builder], boolean), withLocking/598120124=([org.apache.logging.log4j.core.appender.FileAppender$Builder, boolean], org.apache.logging.log4j.core.appender.FileAppender$Builder), build/797536208=([org.apache.logging.log4j.core.appender.FileAppender$Builder], org.apache.logging.log4j.core.appender.FileAppender)}
; {var1242=org.apache.dubbo.common.utils.DubboAppender$Builder, var2737=r1, var1251=org.apache.logging.log4j.core.appender.FileAppender$Builder, var3463=org.apache.logging.log4j.core.appender.FileAppender, var1756=r0, var2170=org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder, var3091=$z0, var1568=org.apache.logging.log4j.core.Layout, var2071=$r2, var2837=$r3, var2768=$r4, var2847=$r5, var3495=$r6, var3393=$r7, var3911=org.apache.logging.log4j.core.config.Configuration, var2959=$r8, var3594=$z1, var1396=$i0, var686=$z2, var1437=$r9, var596=null_type, var66=$r12, var2871=$z3, var332=$z4, var3808=$r10, var260=org.apache.logging.log4j.core.appender.AbstractAppender$Builder}
; {org.apache.dubbo.common.utils.DubboAppender$Builder=var1242, r1=var2737, org.apache.logging.log4j.core.appender.FileAppender$Builder=var1251, org.apache.logging.log4j.core.appender.FileAppender=var3463, r0=var1756, org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder=var2170, $z0=var3091, org.apache.logging.log4j.core.Layout=var1568, $r2=var2071, $r3=var2837, $r4=var2768, $r5=var2847, $r6=var3495, $r7=var3393, org.apache.logging.log4j.core.config.Configuration=var3911, $r8=var2959, $z1=var3594, $i0=var1396, $z2=var686, $r9=var1437, null_type=var596, $r12=var66, $z3=var2871, $z4=var332, $r10=var3808, org.apache.logging.log4j.core.appender.AbstractAppender$Builder=var260}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.utils.DubboAppender$Builder;	r0 = staticinvoke <org.apache.logging.log4j.core.appender.FileAppender: org.apache.logging.log4j.core.appender.FileAppender$Builder newBuilder()>();	$z0 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean isIgnoreExceptions()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setIgnoreExceptions(boolean)>($z0);	$r2 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: org.apache.logging.log4j.core.Layout getLayout()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setLayout(org.apache.logging.log4j.core.Layout)>($r2);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: java.lang.String getName()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-File");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setName(java.lang.String)>($r7);	$r8 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: org.apache.logging.log4j.core.config.Configuration getConfiguration()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractAppender$Builder setConfiguration(org.apache.logging.log4j.core.config.Configuration)>($r8);	$z1 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean isBufferedIo()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder setBufferedIo(boolean)>($z1);	$i0 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: int getBufferSize()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder setBufferSize(int)>($i0);	$z2 = virtualinvoke r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean isImmediateFlush()>();	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.AbstractOutputStreamAppender$Builder setImmediateFlush(boolean)>($z2);	$r9 = r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: java.lang.String fileName>;	if $r9 == null goto $r12 = "dubbo.log";	$r12 = "dubbo.log";	goto [?= virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withFileName(java.lang.String)>($r12)];	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withFileName(java.lang.String)>($r12);	$z3 = r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean append>;	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withAppend(boolean)>($z3);	$z4 = r1.<org.apache.dubbo.common.utils.DubboAppender$Builder: boolean locking>;	virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender$Builder withLocking(boolean)>($z4);	$r10 = virtualinvoke r0.<org.apache.logging.log4j.core.appender.FileAppender$Builder: org.apache.logging.log4j.core.appender.FileAppender build()>();	return $r10
;block_num 3