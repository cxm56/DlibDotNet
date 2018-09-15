﻿using System;
using System.Runtime.InteropServices;

// ReSharper disable once CheckNamespace
namespace DlibDotNet
{

    public sealed class FullDetection : DlibObject
    {

        #region Constructors

        internal FullDetection(IntPtr ptr)
        {
            this.NativePtr = ptr;
        }

        #endregion

        #region Properties

        public double DetectionConfidence
        {
            get
            {
                this.ThrowIfDisposed();
                var detectionConfidence = Native.full_detection_get_detection_confidence(this.NativePtr);
                return detectionConfidence;
            }
        }

        public FullObjectDetection Rect
        {
            get
            {
                this.ThrowIfDisposed();
                var rect = Native.full_detection_get_rect(this.NativePtr);
                return new FullObjectDetection(rect);
            }
        }

        public ulong WeightIndex
        {
            get
            {
                this.ThrowIfDisposed();
                var weightIndex = Native.full_detection_get_weight_index(this.NativePtr);
                return weightIndex;
            }
        }

        #endregion

        #region Methods

        #region Overrides

        protected override void DisposeUnmanaged()
        {
            base.DisposeUnmanaged();

            if (this.NativePtr == IntPtr.Zero)
                return;

            Native.full_detection_delete(this.NativePtr);
        }

        #endregion

        #endregion

        internal sealed class Native
        {

            [DllImport(NativeMethods.NativeLibrary, CallingConvention = NativeMethods.CallingConvention)]
            public static extern double full_detection_get_detection_confidence(IntPtr detection);

            [DllImport(NativeMethods.NativeLibrary, CallingConvention = NativeMethods.CallingConvention)]
            public static extern IntPtr full_detection_get_rect(IntPtr detection);

            [DllImport(NativeMethods.NativeLibrary, CallingConvention = NativeMethods.CallingConvention)]
            public static extern ulong full_detection_get_weight_index(IntPtr detection);

            [DllImport(NativeMethods.NativeLibrary, CallingConvention = NativeMethods.CallingConvention)]
            public static extern void full_detection_delete(IntPtr detection);

        }

    }
}
